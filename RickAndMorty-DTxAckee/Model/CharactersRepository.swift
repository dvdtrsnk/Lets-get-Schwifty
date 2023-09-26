//
//  CharactersRepository.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import Resolver

class CharactersRepository: ObservableObject {
    
    //MARK: - Properties

    @Injected var networkManager: NetworkManager
    @Injected var localDataManager: LocalDataManager
    
    @Published var characters: [CharacterLocal] = []
    
    //MARK: - Init
    
    init() {
        fetchAllCharactersLocal()
        updaterAllCharactersNetworkToLocal()
    }
        
    //MARK: - Public Methods

     func fetchAllCharactersLocal() {
        localDataManager.fetchCharacters { result in
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
    
    //MARK: - Private Method

    private func updaterAllCharactersNetworkToLocal() {
        
        let delayBetweenPages = 1.5
        
        var currentPage = 1
        var pages = 1
        
        func fetchNextPage() {
            networkManager.fetchCharactersPage(currentPage) { result in
                switch result {
                case .success(let response):
                    
                    for character in response.results {
                        self.localDataManager.updateOrCreateLocalCharacterUsing(characterNetwork: character, charactersLocal: self.characters)
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
    
    private func printUpdateStatus(_ currentPage: Int, outOf: Int) {
        if currentPage <= outOf {
            print("Sync Network To Local: \(currentPage) / \(outOf) pages")
        }
        if currentPage == outOf {
            print("Done!")
        }
    }
}
