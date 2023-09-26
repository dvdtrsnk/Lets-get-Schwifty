//
//  CharacterFetchModel.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation

struct CharacterFetchModel: Codable {
    var info: Info
    var results: [CharacterNetwork]
}
