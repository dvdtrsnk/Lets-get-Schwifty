//
//  NetworkServiceProtocol.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData(with urlRequest: URLRequest, completion: @escaping (Result<Data, NetworkFetchErrors>) -> ())
}
