//
//  DetailHeroBuilder.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 23/3/25.
//

import UIKit

final class DetailHeroBuilder {
    
    private var viewModel: DetailHeroViewModel
   
    
    init(_ name: String) {
        let useCase = DetailHeroUseCase(heroName: name)
        self.viewModel = DetailHeroViewModel(useCase: useCase, nameHero: name)
    }
    
    //para los test?
    func set(viewModel: DetailHeroViewModel) -> Self {
        self.viewModel = viewModel
        return self
    }
    
    func build() -> UIViewController {
        let rootViewController = DetailHeroViewController(viewModel: viewModel)
        let controller = UINavigationController(rootViewController: rootViewController)
        //controller.modalPresentationStyle = .fullScreen
        return controller
    }
    
}
