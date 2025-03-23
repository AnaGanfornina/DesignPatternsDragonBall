//
//  HeroListBuilder.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 23/3/25.
//

import UIKit

final class HeroesListBuilder {
    func build() -> UIViewController {
        let useCase = GetHeroesUseCase()
        let viewModel = HeroesListViewModel(useCase: useCase)
        let rootViewController = HeroesListViewController(viewModel: viewModel)
        
        
        let controller = UINavigationController(rootViewController: rootViewController)
        controller.modalPresentationStyle = .fullScreen
        return controller
        
    }
}


