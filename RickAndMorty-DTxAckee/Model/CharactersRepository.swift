//
//  CharactersRepository.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import Resolver
import Combine

class CharactersRepository: CharactersRepositoryProtocol {
    
    //MARK: - Properties

    @Injected var networkManager: CharacterNetworkManagerProtocol
    @Injected var localManager: CharacterLocalManagerProtocol
    
    private let charactersSubject = CurrentValueSubject<[CharacterLocal], Never>([])
    var charactersPublisher: AnyPublisher<[CharacterLocal], Never> {
        return charactersSubject.eraseToAnyPublisher()
    }
    
    var characters: [CharacterLocal] = [] {
        didSet {
            charactersSubject.send(characters)
        }
    }
        
    //MARK: - Public Methods

     func fetchAllCharactersLocal() {
        localManager.fetchCharacters { result in
            switch result {
            case .success(let loaded):
                DispatchQueue.main.async {
                    self.characters = loaded
                }
            case .failure(let error):
                print("Error fetching Characters Local: \(error)")
                
            }
        }
    }

    func updateAllCharactersNetworkToLocal() {
        fetchAllCharactersLocal()
        
        
        let delayBetweenPages = 1.5
        
        var currentPage = 1
        var pages = 1
        
        func fetchNextPage() {
            networkManager.fetchCharactersPage(currentPage) { result in
                switch result {
                case .success(let response):
                    
                    for character in response.results {
                        self.localManager.updateOrCreateLocalCharacterUsing(characterNetwork: character, charactersLocal: self.charactersSubject.value)
                    }
                    self.printUpdateStatus(currentPage, outOf: response.info.pages)
                    
                    self.fetchAllCharactersLocal()
                    pages = response.info.pages
                    
                    if currentPage < pages {
                        currentPage += 1
                        DispatchQueue.global().asyncAfter(deadline: .now() + delayBetweenPages) {
                            fetchNextPage()
                        }
                    }
                case .failure(let error):
                    print("Failed to fetch Characters page \(currentPage): \(error)")
                }
            }
        }
        
        fetchNextPage()
    }
    
    // MARK: - Private Methods 
    
    private func printUpdateStatus(_ currentPage: Int, outOf: Int) {
        if currentPage <= outOf {
            print("Sync Network To Local: \(currentPage) / \(outOf) pages")
        }
        if currentPage == outOf {
            print("Done!")
        }
    }
}
