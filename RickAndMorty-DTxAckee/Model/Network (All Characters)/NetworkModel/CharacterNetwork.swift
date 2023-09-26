//
//  CharacterModel.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import SwiftUI

struct CharacterNetwork: Codable {
    var id: Int16
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: OriginOrLocation
    var location: OriginOrLocation
    var image: String
    var url: String
    var created: String
}


