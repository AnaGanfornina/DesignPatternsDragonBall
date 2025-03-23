//
//  DetailHeroViewMoelTest.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 23/3/25.
//


import XCTest

@testable import DesignPatternsDragonBall

private extension HeroModel {
    static let dummyObject = HeroModel(identifier: "1",
                                       name: "NombreHero",
                                       description: "Test",
                                       photo: "Test",
                                       favorite: false)
}

// MARK: -  Mocks
private final class SucceessDetailHeroUseCase: DetailHeroUseCaseProtocol {
    func run(heroName: String, completion: @escaping (Result<[HeroModel], Error>) -> Void) {
        completion(.success([.dummyObject]))
    }
    
    private final class FailureDetailHeroUseCase: DetailHeroUseCaseProtocol {
        func run(heroName: String, completion: @escaping (Result<[HeroModel],  Error>) -> Void) {
            completion(.failure(Error.self as! Error))
        }
        
        
        
        
    }
    
    // MARK: - Test
    final class DetailHeroViewModelTest: XCTestCase {
        
        func test_whenUseCaseSucceess_StateIsSucess(){
            // Given
            
            let useCase = SucceessDetailHeroUseCase()
            let sut = DetailHeroViewModel(useCase: useCase, nameHero: "NombreHero")
            
            let successExpectation = expectation(description: "Success hero")
            
            // When
            
            sut.onStateChanged.bind { state in
                if state == .succcess {
                    successExpectation.fulfill()
                }
                
            }
            sut.loadHero()
            
            // Then
            wait(for: [successExpectation],timeout: 3)
            XCTAssertEqual(sut.hero, [.dummyObject])
        }
        
        func test_whenUseCasefailure_StateIsFailure(){
            // Given
            
            let useCase = FailureDetailHeroUseCase()
            let sut = DetailHeroViewModel(useCase: useCase, nameHero: "Nombre_Hero")
            
            let failureExpectation = expectation(description: "failure hero")
            
            // When
            
            sut.onStateChanged.bind { state in
                if state == .error(reason: "No tengo datos del héroe") {
                    failureExpectation.fulfill()
                }
                
            }
            sut.loadHero()
            
            // Then
            wait(for: [failureExpectation],timeout: 3)
            XCTAssertEqual(sut.hero, [.dummyObject])
        }
    }
    
}
