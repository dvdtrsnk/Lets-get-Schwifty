//
//  CharacterCardViewModel.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import Resolver

class CharacterCardViewModel: ObservableObject {
    
    // MARK: - Properties
    let character: CharacterLocal
    
    
    // MARK: - Init
    init(_ character: CharacterLocal) {
        self.character = character
    }

}
