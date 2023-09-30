//
//  MockDataController.swift
//  RickAndMorty-DTxAckee_Tests
//
//  Created by David Tresnak
//

import Foundation
import CoreData
@testable import RickAndMorty_DTxAckee

class MockDataController: DataControllerProtocol {
    
    // MARK: - Properties
    
    var container: NSPersistentContainer
    var moc: NSManagedObjectContext {
        return container.viewContext
    }
    
    var shouldReturnError = false
    
    // MARK: - Init
    
    init() {
        container = NSPersistentContainer(name: "RickAndMorty")

        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
