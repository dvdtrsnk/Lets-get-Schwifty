//
//  NetworkManager.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import Resolver

class CharacterNetworkManager: CharacterNetworkManagerProtocol {
    // MARK: - Properties
    @Injected private var networkService: NetworkServiceProtocol
    var baseURL = "https://rickandmortyapi.com/api/character"
    // MARK: - Public Methods
    func fetchCharactersPage(_ number: Int) async throws -> CharacterFetchModel {
        guard let url = URL(string: baseURL + "?page=" + String(number)) else {
            throw NetworkFetchErrors.urlError
        }
        do {
            let data = try await networkService.fetchData(from: url)
            if let decoded = decodeCharacters(from: data) {
                return decoded
            } else {
                throw NetworkFetchErrors.decodingError
            }
        } catch {
            throw error
        }
    }
    // MARK: - Private Methods
    private func decodeCharacters(from data: Data) -> CharacterFetchModel? {
        do {
            let decoded = try JSONDecoder().decode(CharacterFetchModel.self, from: data)
            return decoded
        } catch {
            return nil
        }
    }
}
