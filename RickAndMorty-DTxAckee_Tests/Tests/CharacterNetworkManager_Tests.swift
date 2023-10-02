//
//  NetworkManager_Tests.swift
//  RickAndMorty-DTxAckee_Tests
//
//  Created by David Tresnak
//

import XCTest
import Resolver
@testable import RickAndMorty_DTxAckee

final class CharacterNetworkManager_Tests: XCTestCase {
    
    // MARK: - Properties
    @LazyInjected var networkService: MockNetworkService
    var sut: CharacterNetworkManager?
    let correctUrl = "https://rickandmortyapi.com/api/character"
    
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        Resolver.registerMockServices()
        sut = CharacterNetworkManager()
    }
    
    override func tearDown() {
        sut = nil
        Resolver.root = .main
        super.tearDown()
    }
    
    
    // MARK: - Unit tests
    
    func test_CharacterNetworkManager_BaseURL_IsCorrect() {
        // Given
        let correctBaseUrl = "https://rickandmortyapi.com/api/character"
        
        // When
        let setUrl = sut?.baseURL
        
        // Then
        XCTAssertEqual(correctBaseUrl, setUrl) // Checks if SUT is using correct api url
    }
    
    func test_CharacterNetworkManager_FetchCharactersPage_Success() {
        // Given
        let expectation = XCTestExpectation(description: "Call a network async")
        let data = returnMockData()
        networkService.result = .success(data)
        
        var loadedData: CharacterFetchModel?
        var loadedError: RickAndMorty_DTxAckee.NetworkFetchErrors?
        
        // When
        
        sut?.fetchCharactersPage(1) { result in
            switch result {
            case .success(let data):
                expectation.fulfill()
                loadedData = data
            case .failure(let error):
                loadedError = error
            }
            
            // Then
            XCTAssertNil(loadedError) // Checks if inserted completion goes through
            XCTAssertNotNil(loadedData)
            
            guard let loadedData = loadedData else { return }
            XCTAssertEqual(loadedData.results.count, 1) // Checks if data Decode to CharacterLocal
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_CharacterNetworkManager_FetchCharactersPage_Failure() {
        // Given
        let expectation = XCTestExpectation(description: "Call a network async")

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
                expectation.fulfill()
                loadedError = error
            }
            
            
            // Then
            XCTAssertNil(loadedData)
            XCTAssertEqual(networkError, loadedError) // Checks if inserted error goes through in case of failure
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}


// MARK: - Helper Functions

extension CharacterNetworkManager_Tests {
    
    private func mockCharacter() -> [CharacterNetwork] {
   [CharacterNetwork(id: 1, name: "", status: "", species: "", type: "", gender: "", origin: OriginOrLocation(name: "", url: ""), location: OriginOrLocation(name: "", url: ""), image: "", url: "", created: "")]
    }

  private func returnMockData() -> Data {
    let asset = mockCharacter()
    let test = try? JSONEncoder().encode(CharacterFetchModel(info: Info(count: 800, pages: 40), results: asset))
    return test ?? Data()
  }
    
}
