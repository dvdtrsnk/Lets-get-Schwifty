//
//  NetworkManager.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation


class NetworkManager: NetworkManagerProtocol {
    
    //MARK: - Properties
    
    let baseURL = "https://rickandmortyapi.com/api/character"
    
    
    //MARK: - Public Methods

    func fetchCharactersPage(_ number: Int, completion: @escaping (Result<CharacterFetchModel, NetworkFetchErrors>) -> ()) {
        guard let requestURL = URL(string: baseURL+"?page="+String(number)) else {
            completion(.failure(.urlError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, resp, err in
            guard let httpResponse = resp as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.responseError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                let loaded = try JSONDecoder().decode(CharacterFetchModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(loaded))
                }
            }
            catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
