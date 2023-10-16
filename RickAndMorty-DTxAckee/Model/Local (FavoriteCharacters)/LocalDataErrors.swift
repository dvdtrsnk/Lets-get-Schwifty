//
//  LocalDataErrors.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation

enum LocalDataErrors: Error {
    case fetchError
    var localizedDescription: String {
        switch self {
        case .fetchError:
            return "Unable to load data"
        }
    }
}
