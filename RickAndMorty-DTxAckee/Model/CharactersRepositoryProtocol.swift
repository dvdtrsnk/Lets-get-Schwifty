//
//  CharactersRepositoryProtocol.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Třešňák on 29.09.2023.
//

import Foundation
import Combine

protocol CharactersRepositoryProtocol {
    
    var charactersPublisher: AnyPublisher<[CharacterLocal], Never> { get }
    
    func fetchAllCharactersLocal()
    func updaterAllCharactersNetworkToLocal()
}
