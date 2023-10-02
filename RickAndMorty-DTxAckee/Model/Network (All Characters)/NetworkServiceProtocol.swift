//
//  NetworkServiceProtocol.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData(from url: URL) async throws -> Data
}
