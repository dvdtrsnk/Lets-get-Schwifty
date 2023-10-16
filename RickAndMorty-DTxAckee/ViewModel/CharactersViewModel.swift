//
//  CharactersViewModel.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import Combine
import Resolver

class CharactersViewModel: ObservableObject {
    // MARK: - Properties
    @Injected var charactersRepository: CharactersRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = []

    var characters: [CharacterLocal] = [] {
        didSet {
            filterCharacters()
        }
    }
    @Published var searchField = "" {
        didSet {
            filterCharacters()
        }
    }
    @Published var charactersFiltered: [CharacterLocal] = []

    // MARK: - Init
    init() {
        charactersRepository.charactersPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.characters, on: self)
            .store(in: &cancellables)
    }
    // MARK: - Private Methods
    private func filterCharacters() {
        if searchField.isEmpty {
            charactersFiltered = characters
        } else {
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                let filteredCharacters = self.characters.filter { $0.name.contains(self.searchField) }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.charactersFiltered = filteredCharacters
                }
            }
        }
    }

}
