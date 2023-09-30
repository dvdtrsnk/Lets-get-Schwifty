//
//  LocalDataManager.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import Resolver
import CoreData

class CharacterLocalDataManager: CharacterLocalManagerProtocol {
    
    //MARK: - Properties
    
    @Injected var dataController: DataControllerProtocol

    //MARK: - Public Methods
    
    func fetchCharacters(completion: @escaping (Result<[CharacterLocal], LocalDataErrors>) -> Void) {
        let request = NSFetchRequest<CharacterLocal>(entityName: "CharacterLocal")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            let characters = try dataController.moc.fetch(request)
            completion(.success(characters))
        } catch {
            completion(.failure(.fetchError))
        }
    }
    
    func updateOrCreateLocalCharacterUsing(characterNetwork: CharacterNetwork, charactersLocal: [CharacterLocal]) {
                
        let localCharacter = loadOrCreate(characterNetwork, in: charactersLocal)
        localCharacter.id = characterNetwork.id
        localCharacter.name = characterNetwork.name
        localCharacter.status = characterNetwork.status
        localCharacter.species = characterNetwork.species
        localCharacter.type = characterNetwork.type
        localCharacter.gender = characterNetwork.gender
        localCharacter.originName = characterNetwork.origin.name
        localCharacter.locationName = characterNetwork.location.name
        localCharacter.imageUrl = characterNetwork.image
        localCharacter.url = characterNetwork.url
        
        saveContext()
    }
    
    func saveContext() {
        if dataController.moc.hasChanges {
            do {
                try dataController.moc.save()
            } catch {
                print("Error saving data")
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func loadOrCreate(_ character: CharacterNetwork, in charactersLocal: [CharacterLocal]) -> CharacterLocal {
        if let existingLocalCharacter = charactersLocal.first(where: { $0.id == character.id }) {
            return existingLocalCharacter
        } else {
            return CharacterLocal(context: dataController.moc)
        }
    }
}
