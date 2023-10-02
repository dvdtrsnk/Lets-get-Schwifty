//
//  CharactersRepositoryProtocol.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import Combine

protocol CharactersRepositoryProtocol {
    
    // MARK: - Properties
    
    var charactersPublisher: AnyPublisher<[CharacterLocal], Never> { get }
    var characters: [CharacterLocal] { get set }
    
    //MARK: - Methods
    
    func fetchAllCharactersLocal() async
    func updateAllCharactersNetworkToLocal() async
}
