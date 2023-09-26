//
//  FavoriteCharactersViewModel.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import Combine
import Resolver

class FavoriteCharactersViewModel: ObservableObject {
        
    //MARK: - Properties
    
    @Injected var charactersRepository: CharactersRepository
    @Injected var localDataManager: LocalDataManager
    
    private var cancellables: Set<AnyCancellable> = []

    var characters: [CharacterLocal] = [] {
        didSet {
            filterFavorites()
        }
    }
    @Published var favoriteCharacters: [CharacterLocal] = []
            
    //MARK: - Init
    
    init() {
        charactersRepository.$characters
            .receive(on: DispatchQueue.main)
            .assign(to: \.characters, on: self)
            .store(in: &cancellables)
    }
    
    //MARK: - Private Methods
    
    private func filterFavorites() {
        DispatchQueue.global().async {
            let filteredCharacters = self.characters.filter { $0.isFavorite }
            
            DispatchQueue.main.async {
                self.favoriteCharacters = filteredCharacters
            }
        }
    }
    
}
