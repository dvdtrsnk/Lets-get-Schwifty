//
//  NetworkManager_Tests.swift
//  RickAndMorty-DTxAckee_Tests
//
//  Created by David Třešňák on 29.09.2023.
//

import XCTest
import Resolver
@testable import RickAndMorty_DTxAckee

final class NetworkManager_Tests: XCTestCase {
    
    // MARK: - Properties
    @LazyInjected var networkService: MockNetworkService
    var sut: NetworkManager?
    let correctUrl = "https://rickandmortyapi.com/api/character"
    
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        Resolver.registerMockServices()

        sut = NetworkManager()
    
    }
    
    override func tearDown() {
        sut = nil
        Resolver.root = .main
        super.tearDown()
    }
    
    
    // MARK: - Unit tests
    
    func test_NetworkManager_BaseURL_IsCorrect() {        
        // Given
        let correctBaseUrl = "https://rickandmortyapi.com/api/character"
        
        // When
        let setUrl = sut?.baseURL
        
        // Then
        XCTAssertEqual(correctBaseUrl, setUrl)
    }
    
    
    
    
    func test_NetworkManager_FetchCharactersPage_Success() {
        // Given
        let data = returnMockData()
        networkService.result = .success(data)

        var loadedData: CharacterFetchModel?
        var loadedError: RickAndMorty_DTxAckee.NetworkFetchErrors?

        // When

        sut?.fetchCharactersPage(1) { result in
            switch result {
            case .success(let data):
                loadedData = data
            case .failure(let error):
                loadedError = error
            }

            // Then
            XCTAssertNil(loadedError)
            XCTAssertNotNil(loadedData)
            
            guard let loadedData = loadedData else { return }
            XCTAssertEqual(loadedData.results.count, 1)
        }
    }
    
    func test_NetworkManager_FetchCharactersPage_Failure() {
        // Given
        let networkError = RickAndMorty_DTxAckee.NetworkFetchErrors.responseError
        networkService.result = .failure(networkError)
        
        var loadedData: CharacterFetchModel?
        var loadedError: RickAndMorty_DTxAckee.NetworkFetchErrors?
        
        // When
        
        sut?.fetchCharactersPage(1) { result in
            switch result {
            case .success(let data):
                loadedData = data
            case .failure(let error):
                loadedError = error
            }
            

            // Then
            XCTAssertNil(loadedData)
            XCTAssertEqual(networkError, loadedError)
        }
    }
    
    // MARK: - Helper Functions
    
    
    
    private func mockCharacter() -> [CharacterNetwork] {
   [CharacterNetwork(id: 1, name: "", status: "", species: "", type: "", gender: "", origin: OriginOrLocation(name: "", url: ""), location: OriginOrLocation(name: "", url: ""), image: "", url: "", created: "")]
    }

  private func returnMockData() -> Data {
    let asset = mockCharacter()
    let test = try? JSONEncoder().encode(CharacterFetchModel(info: Info(count: 800, pages: 40), results: asset))
    return test ?? Data()
  }
}
