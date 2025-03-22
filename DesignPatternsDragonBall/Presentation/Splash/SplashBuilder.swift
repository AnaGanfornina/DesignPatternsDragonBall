//
//  SplashBuilder.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 20/3/25.
//

import UIKit

/// Función que construye objeto del SplashViewModel
final class SplashBuilder {
    // Retornamos un UIViewController porque no nos interesa el objeto en concreto que vamos a devolver
    func build() -> UIViewController {
        let viewModel = SplashViewModel()
        
        return SplashViewController(viewModel: viewModel)
    }
}
