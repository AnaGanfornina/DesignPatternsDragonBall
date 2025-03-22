//
//  SplashViewModel.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 20/3/25.
//

import Foundation

/// Definiendo los estados del ViewModel, siendo mas facil para transmitir eventos
enum SplashState: Equatable {
    case loading
    case error
    case ready
}

final class SplashViewModel {
    //Definimos el observable
    
    ///Esto es lo que usaremos para indicar y saber desde fuera en qué estado está nuestro ViewModel
    var onStateChanged = Binding<SplashState>()
    
    /// Flujo de entrada al ViewModel, ejecuta la acción de cargar
    func load() {
        // Me pongo en el estado de que estoy cargando
        onStateChanged.update(.loading)
        
        // cuando pasen 3 segundos paso al estado de que todo ha ido bien
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.onStateChanged.update(.ready)
        }
    }
}
