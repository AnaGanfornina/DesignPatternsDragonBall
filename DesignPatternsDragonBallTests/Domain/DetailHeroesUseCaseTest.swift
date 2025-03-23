//
//  DetailHeroesUseCase.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 23/3/25.
//

import XCTest

@testable import DesignPatternsDragonBall

private extension HeroModel {
    static let dummyObject = HeroModel(identifier: "1",
                                       name: "Ana",
                                       description: "Test",
                                       photo: "Test",
                                       favorite: false)
}

// MARK: -  Mocks





private final class SucceessDetailHeroUseCase: DetailHeroUseCaseProtocol {
    
    
    let heroName: String
    
    init(heroName: String){
        self.heroName = heroName
    }
    
    func run(completion: @escaping (Result<[HeroModel], any Error>) -> Void) {
        completion(.success([.dummyObject]))
    }
    
    
}

// MARK: - Test
final class DetailHeroViewModelTest_: XCTestCase {
    
    func test_whenUseCaseSucceess_StateIsSucess(){
        // Given
        
        
        let name = "Ana"
        let sut = SucceessDetailHeroUseCase(heroName: name)
        //let viewModel = DetailHeroViewModel(useCase: sut, nameHero: name)
        
        let successExpectation = expectation(description: "El nombre es ana")
        
        // When
        
        
        
        sut.run { result in
            // Llamada de red con un mock de red ?
            
        }
        // Then
       
    }
}


