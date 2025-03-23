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
    func run(heroName: String, completion: @escaping (Result<[DesignPatternsDragonBall.HeroModel], any Error>) -> Void) {
        completion(.success([.dummyObject]))
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
}


