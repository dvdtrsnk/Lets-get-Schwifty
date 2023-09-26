//
//  InfoModel.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation

struct Info: Codable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}
