//
//  HeroesListViewModel.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 23/3/25.
//

import Foundation

enum HeroesListState: Equatable {
    case error(reason: String)
    case loading
    case succcess
}

final class HeroesListViewModel {
    let onStateChanged = Binding<HeroesListState>()
    private let useCase: GetHeroesUseCaseProtocol // Es un protocolo para poder invertir la dependencia en un futuro
    private(set) var heroes: [HeroModel] = []  // lo que es privado es unicamente el set
    
    init(useCase: GetHeroesUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func loadHeroes() {
        onStateChanged.update(.loading)
        useCase.run { [weak self] result in
            do {
                self?.heroes = try result.get()
                self?.onStateChanged.update(.succcess)
            } catch {
                self?.onStateChanged.update(.error(reason: "No tengo datos de héroes"))
            }
        }
        
    }
    
}
