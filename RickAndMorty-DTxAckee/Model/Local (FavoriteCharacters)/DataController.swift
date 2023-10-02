//
//  DataController.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import CoreData

class DataController: DataControllerProtocol {
    
    //MARK: - Properties
    var container = NSPersistentContainer(name: "RickAndMorty")
    var moc: NSManagedObjectContext {
        container.viewContext
    }

    //MARK: - Init
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
