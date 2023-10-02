//
//  MockCharactersRepository.swift
//  RickAndMorty-DTxAckee_Tests
//
//  Created by David Tresnak
//

import Foundation
import Combine
@testable import RickAndMorty_DTxAckee

class MockCharactersRepository: ObservableObject, CharactersRepositoryProtocol {
    
    // MARK: - Properties
    
    private let charactersSubject = CurrentValueSubject<[CharacterLocal], Never>([])
    
    var charactersPublisher: AnyPublisher<[CharacterLocal], Never> {
        return charactersSubject.eraseToAnyPublisher()
    }

    var characters: [CharacterLocal] = [] {
        didSet {
            charactersSubject.send(characters)
//            print(characters.count)
//            print(charactersSubject.count())
        }
    }
    
    // MARK: - Methods
    
    func fetchAllCharactersLocal() {
        
    }
    
    func updateAllCharactersNetworkToLocal() {
        
    }
    
    
}
