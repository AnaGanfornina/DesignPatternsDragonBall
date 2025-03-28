//
//  DetailHeroUseCase.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 23/3/25.
//


struct HeroError: Error {
    let reason: String
}

protocol DetailHeroUseCaseProtocol {
    func run(heroName: String, completion: @escaping (Result<[HeroModel], Error>) -> Void)
}

final class DetailHeroUseCase: DetailHeroUseCaseProtocol {
    private let heroName: String
    
    init(heroName: String){
        self.heroName = heroName
    }

    func run(heroName: String, completion: @escaping (Result<[HeroModel], any Error>) -> Void) {
        // Realizar la llamada
        GetHeroesAPIRequest(name: heroName)
            .perform { result in
                do {
                    let hero = try result.get()
                    let mapper = HeroDTOToHeroModelMapper()
                    completion(.success( hero.map { mapper.map($0)}))
                } catch {
                    completion(.failure(error))
                }
            }
    }
    
    
}
