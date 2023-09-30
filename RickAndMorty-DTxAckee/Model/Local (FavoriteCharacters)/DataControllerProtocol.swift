//
//  DataControllerProtocol.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import CoreData

protocol DataControllerProtocol {
    var container: NSPersistentContainer { get }
    var moc: NSManagedObjectContext { get }
}
