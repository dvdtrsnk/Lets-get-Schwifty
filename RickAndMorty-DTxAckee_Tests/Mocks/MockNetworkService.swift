//
//  MockNetworkService.swift
//  RickAndMorty-DTxAckee_Tests
//
//  Created by David Tresnak
//

import Foundation
@testable import RickAndMorty_DTxAckee

class MockNetworkService: NetworkServiceProtocol {
    // MARK: - Properties
    var result: Result<Data, RickAndMorty_DTxAckee.NetworkFetchErrors>?
    // MARK: - Methods
    func fetchData(from url: URL) async throws -> Data {
        guard let result = result else {
            fatalError("Result is nil")
        }
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
}
