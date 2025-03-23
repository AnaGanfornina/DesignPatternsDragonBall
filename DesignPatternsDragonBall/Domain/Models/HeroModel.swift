//
//  HeroModel.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 22/3/25.
//

import Foundation

/// Modelo de datos del dominio
struct HeroModel: Equatable {
    
    let identifier: String
    let name : String
    let description: String
    let photo: String
    let favorite: Bool
    
}
