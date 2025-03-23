//
//  LoginUseCaseTest.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 23/3/25.
//
import XCTest

@testable import DesignPatternsDragonBall

// MARK: -  Mocks

//Para mockear la sesion de la petición de red que actualmente hace nuestro login
final class APISessionMock: APISessionContract {
    let mockResponse: ((any HTTPRequest) -> Result<Data, any Error>)
    
    init(mockResponse: @escaping (any HTTPRequest) -> Result<Data, any Error>) {
        self.mockResponse = mockResponse
    }
    
    func request<Request: HTTPRequest>(apiRequest: Request, completion: @escaping (Result<Data, any Error>) -> Void) {
        completion(mockResponse(apiRequest))
    }
}

private final class SessionDataSourceMock: SessionDataSourceProtocol {
 
    private(set) var session: Data?
        
    func storeSession(_ session: Data?) {
        self.session = session
    }
    
    func getSession() -> Data? { nil }
}

// MARK: - Test

final class LoginUseCaseTests: XCTestCase {
    func testSuccessStoresToken() {
        // Given
        let dataSource = SessionDataSourceMock()
        let sut = LoginUseCase(dataSource: dataSource)
        let successExpectation = expectation(description: "Success")
        APISession.shared = APISessionMock { _ in .success(Data("HelloWorld".utf8)) }
        
        // When
        sut.run(username: "hello@hello", password: "12345") { result in
            if case .success = result {
                successExpectation.fulfill()
            }
        }
        
        // Then
        wait(for: [successExpectation], timeout: 5)
        XCTAssertNotNil(dataSource.session)
    }
}

