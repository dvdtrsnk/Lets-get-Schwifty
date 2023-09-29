//
//  LocalDataManager.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import CoreData

class LocalDataManager: LocalDataManagerProtocol {
    
    //MARK: - Properties
    let container = NSPersistentContainer(name: "RickAndMorty")

    //MARK: - Init
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: - Public Methods
    
    
    func fetchCharacters(completion: @escaping (Result<[CharacterLocal], LocalDataErrors>) -> Void) {
        let request = NSFetchRequest<CharacterLocal>(entityName: "CharacterLocal")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            let characters = try container.viewContext.fetch(request)
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
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
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
            return CharacterLocal(context: container.viewContext)
        }
    }
    
}
