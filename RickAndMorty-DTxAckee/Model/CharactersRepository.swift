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
        do {
            characters = try localManager.fetchCharacters()
        } catch {
            print(error)
        }
    }
    
    func updateAllCharactersNetworkToLocal() async {
        let delayBetweenPages = 1.5
        var currentPage = 1
        var pages = 2
        
        fetchAllCharactersLocal()
        while currentPage <= pages {

            do {
                let page = try await networkManager.fetchCharactersPage(currentPage)
                pages =  page.info.pages
                for character in page.results {
                    self.localManager.updateOrCreateLocalCharacterUsing(characterNetwork: character, charactersLocal: self.charactersSubject.value)
                }
    
                fetchAllCharactersLocal()
                self.printUpdateStatus(currentPage, outOf: pages)
                currentPage += 1
                try await Task.sleep(nanoseconds: UInt64(delayBetweenPages * 1000_000_000))
                
            } catch {
                print("Failed to fetch characters page \(currentPage): \(error)")
            }
        }
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
