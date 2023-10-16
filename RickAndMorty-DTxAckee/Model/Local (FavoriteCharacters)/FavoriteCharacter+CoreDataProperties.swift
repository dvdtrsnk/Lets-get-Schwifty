//
//  FavoriteCharacter+CoreDataProperties.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Třešňák on 25.09.2023.
//
//

import Foundation
import CoreData

extension FavoriteCharacter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCharacter> {
        return NSFetchRequest<FavoriteCharacter>(entityName: "FavoriteCharacter")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?

}

extension FavoriteCharacter: Identifiable {
}
