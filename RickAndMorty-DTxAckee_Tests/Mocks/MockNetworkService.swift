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
    
    // MARK: - func

    func fetchData(with urlRequest: URLRequest, completion: @escaping (Result<Data, RickAndMorty_DTxAckee.NetworkFetchErrors>) -> ()) {
        guard let result = result else {
            fatalError("Result is nil")
        }
        return completion(result)
    }
}
