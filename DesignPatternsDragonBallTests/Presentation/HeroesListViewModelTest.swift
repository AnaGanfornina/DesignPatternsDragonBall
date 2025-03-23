//
//  HeroesListViewModelTest.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 23/3/25.
//

import XCTest

@testable import DesignPatternsDragonBall


//objeto dummy para probarlo mas adelante

private extension HeroModel {
    static let dummyObject = HeroModel(identifier: "1",
                                       name: "Test",
                                       description: "Test",
                                       photo: "Test",
                                       favorite: false)
}

// MARK: -  Mocks
private final class SuccessGetHeroesUseCase: GetHeroesUseCaseProtocol {
    func run(completion: @escaping (Result<[HeroModel], any Error>) -> Void) {
        completion(.success([.dummyObject]))
    }
}

// MARK: - Test

final class HeroesListViewModelTest: XCTestCase {
    func test_whenUseCaseSucceess_StateIsSucess() {
        // Given
        
        let useCase = SuccessGetHeroesUseCase()
        let sut = HeroesListViewModel(useCase: useCase)// Este useCase siempre va a retornar un dummyObjet
        
        let successExpectation = expectation(description: "Success scenario")
        
        // When
        
        sut.onStateChanged.bind { state in
            if state == .succcess {
                successExpectation.fulfill()
            }
        }
        sut.loadHeroes()
        // Then
        
        wait(for: [successExpectation],timeout: 3)
        XCTAssertEqual(sut.heroes, [.dummyObject])
    }
    
    
}
