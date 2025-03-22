//
//  LoginUseCase.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 22/3/25.
//

import Foundation

// No importamos UIKit porque el dominio no tiene nada que ver con la presentación


/// En el caso de uso no tenemos en Binding por lo que necesitamos nuestros "propios" errores para pasarlos al viewModel mediante el completion
struct LoginError: Error {
    let reason: String
}


protocol LoginUseCaseProtocol {
    //Para poder invertir la dependencia con el caso de uso que tiene que tener el LoginViewModel
    func run(username: String, password: String, completion: @escaping(Result<Void,LoginError>) -> Void)
}



/// Es quien aplica la lógica de negocio, en este caso el login
final class LoginUseCase: LoginUseCaseProtocol {
    
    func run(username: String, password: String, completion: @escaping(Result<Void,LoginError>) -> Void){
        
        guard isValidUserName(username) else {
            return completion(.failure(LoginError(reason: "El usuario no es válido")))
        }
        guard isValidPassword(password) else {
            return completion(.failure(LoginError(reason: "La contraseña no es válida")))
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            completion(.success(()))
            
        }
    }
    
    private func isValidUserName(_ string: String) -> Bool {
        !string.isEmpty && string.contains("@")
    }
    
    private func isValidPassword(_ string: String) -> Bool {
        string.count >= 4
    }
}
