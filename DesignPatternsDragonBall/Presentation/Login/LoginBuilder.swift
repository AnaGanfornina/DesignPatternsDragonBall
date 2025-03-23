//
//  LoginBuilder.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 22/3/25.
//

import UIKit

final class LoginBuilder {
    func build() -> UIViewController {
        let useCase = LoginUseCase(dataSource: SessionDataSource.shared)
        let viewModel = LoginViewModel(useCase: useCase)
        let controller = LoginViewController(viewModel: viewModel)
        controller.modalPresentationStyle = .fullScreen // para poder presentar en pantalla completa la siguiente pantalla
        return controller
        
    }
}

