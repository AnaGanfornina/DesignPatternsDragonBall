//
//  APIInterceptor.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 23/3/25.
//

import Foundation

// interferimos antes de enviar la petición
// Para todas las peticiones que tenemos que hacer, si tenemos un token lo añadimos como parte de la cabecera

/// Protocolo común para Request y response interceptos
protocol APIInterceptor {  }

/// Para todas las peticiones que tenemos que hacer, si tenemos un token lo añadimos como parte de la cabecera
protocol APIRequestInterceptor: APIInterceptor {
    func intercept(_ request: URLRequest) -> URLRequest
}


// Authentication APIInterceptor

/// Para todas las peticiones que tenemos que hacer, si tenemos un token lo añadimos como parte de la cabecera, lo usamos en el APISession
final class AuthenticationAPIInterceptor: APIRequestInterceptor {
    
    private let dataSource: SessionDataSourceProtocol
    
    init(dataSource: SessionDataSourceProtocol = SessionDataSource.shared) {
        self.dataSource = dataSource
    }
    func intercept(_ request: URLRequest) -> URLRequest {
        // combpruebo que tengo sesion
        
        guard let session = dataSource.getSession() else { return request }
        
        
        // si la tengo te seteo una cabecera
        var copy = request
        copy.setValue("Bearer \(String(decoding: session, as: UTF8.self))",
                         forHTTPHeaderField: "Authorization")
        
        return copy
    }
    
    
}
