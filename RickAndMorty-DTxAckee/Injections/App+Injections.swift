//
//  App+Injections.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak


import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        defaultScope = .graph
        
        // MARK: - Data
        register { NetworkManager() }.implements(NetworkManagerProtocol.self)
        register { LocalDataManager() }.implements(LocalDataManagerProtocol.self)
        register { CharactersRepository() }.implements(CharactersRepositoryProtocol.self)
            .scope(.application)
        
        // MARK: - ViewModels
        register { CustomTabBarViewModel() }
            .scope(.application)
        register { CharactersViewModel() }
        register { FavoriteCharactersViewModel() }
        register { _, args in
            CharactersDetailViewModel(args())
        }
        register { _, args in
            CharacterCardViewModel(args())
        }
        
    }
}


