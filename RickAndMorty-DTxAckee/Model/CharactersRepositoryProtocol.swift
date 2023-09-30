//
//  CharactersRepositoryProtocol.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import Combine

protocol CharactersRepositoryProtocol {
    
    var charactersPublisher: AnyPublisher<[CharacterLocal], Never> { get }
    
    func fetchAllCharactersLocal()
    func updateAllCharactersNetworkToLocal()
}
