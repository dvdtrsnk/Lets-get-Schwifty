//
//  CharacterLocal+CoreDataProperties.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//
//

import Foundation
import CoreData


extension CharacterLocal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterLocal> {
        return NSFetchRequest<CharacterLocal>(entityName: "CharacterLocal")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String
    @NSManaged public var isFavorite: Bool
    @NSManaged public var status: String
    @NSManaged public var species: String
    @NSManaged public var type: String
    @NSManaged public var gender: String
    @NSManaged public var originName: String
    @NSManaged public var locationName: String
    @NSManaged public var imageUrl: String
    @NSManaged public var url: String

}

extension CharacterLocal : Identifiable {

}
