//
//  DetailHeroViewModel.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 23/3/25.
//

enum DetailHeroState: Equatable {
    case error(reason: String)
    case loading
    case succcess
}

final class DetailHeroViewModel {
    let onStateChanged = Binding<DetailHeroState>()
    private let useCase: DetailHeroUseCaseProtocol // Es un protocolo para poder invertir la dependencia en un futuro
    private(set) var hero: [HeroModel]?
    private var nameHero : String
    
    init(useCase: DetailHeroUseCaseProtocol, nameHero: String) {
        self.useCase = useCase
        self.nameHero = nameHero
        
        
        
    }
    
    func loadHero(){
        onStateChanged.update(.loading)
        
        useCase.run() {[weak self] result in
            do {
                self?.hero = try result.get()
                self?.onStateChanged.update(.succcess)
                
            } catch {
                self?.onStateChanged.update(.error(reason: "No tengo datos del héroe"))
            }
        }
        
    }
}
