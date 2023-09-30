//
//  Resolver+XCTest.swift
//  RickAndMorty-DTxAckee_Tests
//
//  Created by David Tresnak
//

import Foundation
import Resolver
@testable import RickAndMorty_DTxAckee

extension Resolver {
    // MARK: - Mock Container
    static var mock = Resolver(child: .main)
    
    // MARK: - Register Mock Services
    static func registerMockServices() {
        Resolver.root = Resolver.mock
        defaultScope = .application
        Resolver.mock.register { MockNetworkService() }.implements(NetworkServiceProtocol.self)
        Resolver.mock.register { MockDataController() }.implements(DataControllerProtocol.self)
        Resolver.mock.register { MockCharactersRepository() }.implements(CharactersRepositoryProtocol.self)
    }
}

