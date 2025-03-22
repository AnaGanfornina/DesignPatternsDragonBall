//
//  LoginViewModel.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 22/3/25.
//

import Foundation


enum loginState: Equatable {
    case success
    case loading
    case error(reason: String)
}

/// Es quien REPRESENTA la logica de negocio aplicada por el caso de uso
final class LoginViewModel {
    let useCase: LoginUseCaseProtocol
    let onStateChanged = Binding<loginState>()
    
    
    // MARK: - Inicializer
    
    init(useCase: LoginUseCaseProtocol) {
        self.useCase = useCase
    }
    
    
    
    /// Función que será lanzada cuando reciba un evento(pulse el botón de login)
    func login(username: String?, password: String?){
        
        onStateChanged.update(.loading)
        
        //llamamos al caso de uso que es quien aplica la lógica de negocio
        useCase.run(username: username ?? "", password: password ?? "") {[weak self] result in
            // donde interpreto el código de error en caso de que lo hubiera
            switch result {
            case .success:
                self?.onStateChanged.update(.success)
            case .failure(let error):
                self?.onStateChanged.update(.error(reason: error.reason))
            }
        }
        
       
       
        
    }
    
}
