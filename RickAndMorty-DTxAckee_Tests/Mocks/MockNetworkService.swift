//
//  MockNetworkService.swift
//  RickAndMorty-DTxAckee_Tests
//
//  Created by David Třešňák on 29.09.2023.
//

import Foundation
@testable import RickAndMorty_DTxAckee

class MockNetworkService: NetworkServiceProtocol {
    
    var result: Result<Data, RickAndMorty_DTxAckee.NetworkFetchErrors>?

    func fetchData(with urlRequest: URLRequest, completion: @escaping (Result<Data, RickAndMorty_DTxAckee.NetworkFetchErrors>) -> ()) {
        
        guard let result = result else {
            fatalError("Result is nil")
        }
        return completion(result)
    }
}
