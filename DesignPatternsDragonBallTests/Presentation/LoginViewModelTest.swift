//
//  LoginViewModelTest.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 22/3/25.
//

import XCTest
@testable import DesignPatternsDragonBall

// MARK: -  Mocks
final class SuccessLoginUseCase: LoginUseCaseProtocol {
    func run(username: String, password: String, completion: @escaping (Result<Void, LoginError>) -> Void) {
        completion(.success(()))
    }
}

final class FailedLoginUseCase: LoginUseCaseProtocol {
    func run(username: String, password: String, completion: @escaping (Result<Void, LoginError>) -> Void) {
        completion(.failure(LoginError(reason: "Usuario o contraseña incorrectos")))
    }
}

// MARK: - Test

final class LoginViewModelTest: XCTestCase {
    
    /// Si el caso de uso da un ok yo transiciono a un ok
    func test_When_UseCaseSucceeds_StateIsSuccess() {
        // Given
        let useCase = SuccessLoginUseCase()
        let sut = LoginViewModel(useCase: useCase)
        sut.login(username: "", password: "")
        
        // Tenemos que poner una espectativa que se debe cumplir pues es un test asincrono
        // Son los estados por lo que debemos transicionar
        let loadingExpectation = expectation(description: "View is loading")
        let successExpectation = expectation(description: "View has succeed")
        
        // When
        
        sut.onStateChanged.bind {state in
            if state == .loading {
                loadingExpectation.fulfill() // El full fill lo que hace es check, que esl o que compbrobamos luego en el assert, que los dos sean check y hayan pasado por aqui
            } else if state == .success {
                successExpectation.fulfill()
            }
            
        }
        
        sut.login(username: "", password: "")
        // Para que no se queden los test esperando una respuesta que nunca llega
        wait(for: [loadingExpectation, successExpectation], timeout: 5)
        
        // Then
        
        
    }
    
    func test_When_UseCaseFails_StateIsError() {
        // Given
        let useCase = FailedLoginUseCase()
        let sut = LoginViewModel(useCase: useCase)
        sut.login(username: "", password: "")
        
        let expectedText = "Usuario o contraseña incorrectos"
        let loadingExpectation = expectation(description: "View is loading")
        let failureExpectation = expectation(description: "View has failed")
        
        // When
        
        sut.onStateChanged.bind {state in
            switch state {
            case .loading: loadingExpectation.fulfill()
            case .error(let reason):
                XCTAssertEqual(reason, expectedText)
                failureExpectation.fulfill()
            default: break
            }
            
        }
        
        sut.login(username: "", password: "")
        // Para que no se queden los test esperando una respuesta que nunca llega
        wait(for: [loadingExpectation, failureExpectation], timeout: 5)
        
        // Then
        
        
    }
}
