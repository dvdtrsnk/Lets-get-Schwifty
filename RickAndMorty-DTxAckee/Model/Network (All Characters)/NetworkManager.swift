//
//  NetworkManager.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import Resolver

class NetworkManager: NetworkManagerProtocol {
    
    //MARK: - Properties
    
    @Injected private var networkService: NetworkServiceProtocol
    var baseURL = "https://rickandmortyapi.com/api/character"
    
    //MARK: - Public Methods
    
    func fetchCharactersPage(_ number: Int, completion: @escaping (Result<CharacterFetchModel, NetworkFetchErrors>) -> ()) {
        guard let url = URL(string: baseURL+"?page="+String(number)) else {
            completion(.failure(.urlError))
            return
        }
        
        networkService.fetchData(with: URLRequest(url: url)) { response in
            switch response {
            case .success(let data):
                print("success")
                if let decoded = self.decodeCharacters(from: data) {
                    completion(.success(decoded))
                } else {
                    completion(.failure(.decodingError))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    //MARK: - Private Methods
    
    private func decodeCharacters(from data: Data) -> CharacterFetchModel? {
        do {
            let loaded = try JSONDecoder().decode(CharacterFetchModel.self, from: data)
            return loaded
        }
        catch {
            return nil
        }
    }
}
