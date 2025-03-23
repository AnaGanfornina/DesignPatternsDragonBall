//
//  GetHeroesUseCase.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 22/3/25.
//

import Foundation

protocol GetHeroesUseCaseProtocol {
    func run(completion: @escaping (Result<[HeroModel], Error>) -> Void)
}

final class GetHeroesUseCase: GetHeroesUseCaseProtocol {
    func run(completion: @escaping (Result<[HeroModel], Error>) -> Void) {
        //Realizamos la llamada
        GetHeroesAPIRequest()
            .perform { result in
                do {
                    let heroes = try result.get()
                    let mapper = HeroDTOToHeroModelMapper()
                    completion(.success(heroes.map { mapper.map($0) })) // A todos los elementos del array de superheroes, aplicales la funcion map la cual hace el mapeo dentro del maper. (Es un maper general donde aplicamos un mapper personal)
                } catch {
                    completion(.failure(error))
                }
            }
        
    }
    
    
}
