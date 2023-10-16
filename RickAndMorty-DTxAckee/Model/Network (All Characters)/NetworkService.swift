//
//  NetworkService.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import SwiftUI

class NetworkService: NetworkServiceProtocol {
    func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NetworkFetchErrors.responseError
        }
        return data
    }
}
