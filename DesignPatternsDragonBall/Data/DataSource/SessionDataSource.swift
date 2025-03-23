//
//  SessionDataSource.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 23/3/25.
//

import Foundation
//fuente de datos

protocol SessionDataSourceProtocol {
    /// Almacenan información (token)
    func storeSession(_ session: Data?)
    
    /// Obtienes información  (token)
    func getSession() -> Data?
    
}

/// Clase en la cual vamos a almacenar el token
final class SessionDataSource: SessionDataSourceProtocol {
    static let shared: SessionDataSourceProtocol = SessionDataSource()
    
    private var token: Data?
    
    func storeSession(_ session: Data?) {
        self.token = session
    }
    
    func getSession() -> Data? {
        return self.token
    }
    
    
}
