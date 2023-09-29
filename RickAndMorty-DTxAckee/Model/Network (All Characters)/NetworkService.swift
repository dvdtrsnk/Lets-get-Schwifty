
//
//  NetworkService.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import SwiftUI

class NetworkService: NetworkServiceProtocol {
    func fetchData(with urlRequest: URLRequest, completion: @escaping (Result<Data, NetworkFetchErrors>) -> ()) {
        URLSession.shared.dataTask(with: urlRequest) { data, resp, err in
            guard let httpResponse = resp as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.responseError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
                        
            completion(.success(data))
        }
        .resume()
        
    }
}
