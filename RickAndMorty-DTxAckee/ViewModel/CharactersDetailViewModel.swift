//
//  CharactersDetailViewModel.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import Resolver

class CharactersDetailViewModel: ObservableObject {
    
    
    // MARK: - Properties
    @Injected var localDataManager: CharacterLocalManagerProtocol
    @Injected var charactersRepository: CharactersRepositoryProtocol
    @Published var character: CharacterLocal
    @Published var isFavorite: Bool
    
    
    // MARK: - Init
    init(_ character: CharacterLocal) {
        self.character = character
        self.isFavorite = character.isFavorite
    }
    
    // MARK: - Public Methods
    
    func switchIsFavorite() async {
        DispatchQueue.main.async {
            self.isFavorite = self.character.isFavorite
        }
        
        character.isFavorite = !character.isFavorite
        localDataManager.saveContext()
        
        
        await charactersRepository.fetchAllCharactersLocal()
    }
}
