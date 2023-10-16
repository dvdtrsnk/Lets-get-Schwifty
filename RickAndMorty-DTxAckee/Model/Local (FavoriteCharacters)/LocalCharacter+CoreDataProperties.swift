//
//  LocalCharacter+CoreDataProperties.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Třešňák on 25.09.2023.
//
//

import Foundation
import CoreData

extension LocalCharacter: CharacterProtocol {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalCharacter> {
        return NSFetchRequest<LocalCharacter>(entityName: "LocalCharacter")
    }

    @NSManaged public var isFavorite: Bool
    @NSManaged public var gender: String
    @NSManaged public var id: Int16
    @NSManaged public var imageName: String?
    @NSManaged public var locationName: String
    @NSManaged public var name: String
    @NSManaged public var originName: String
    @NSManaged public var species: String
    @NSManaged public var status: String
    @NSManaged public var type: String
    @NSManaged public var image: String

}

extension LocalCharacter: Identifiable {

}
