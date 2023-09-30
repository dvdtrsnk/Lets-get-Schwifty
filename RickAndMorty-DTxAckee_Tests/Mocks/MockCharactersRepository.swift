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
    
    
    private let charactersSubject = CurrentValueSubject<[CharacterLocal], Never>([])
    
    var charactersPublisher: AnyPublisher<[CharacterLocal], Never> {
        return charactersSubject.eraseToAnyPublisher()
    }
    
    
    
    func fetchAllCharactersLocal() {
        
    }
    
    func updateAllCharactersNetworkToLocal() {
        
    }
    
    
}
