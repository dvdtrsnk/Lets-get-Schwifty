//
//  NetworkFetchErrors.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation

enum NetworkFetchErrors: Error {

    case decodingError
    case dataError
    case urlError
    case responseError
    case unknownError

    var localizedDescription: String {
        switch self {
        case .decodingError:
            return "Decoding failed"
        case .dataError:
            return "Data error"
        case .urlError:
            return "URL error"
        case .responseError:
            return "Response error"
        case .unknownError:
            return "Unknown error"
        }
    }
}
