//
//  HeroEntity.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 22/3/25.
//

import Foundation

/// Modelo de datos para comunicarnos con la API
struct HeroDTO: Codable {
    let identifier: String
    let name: String
    let description: String
    let photo: String
    let favorite: Bool
    
    //Queremos que nos cambie el identifier por un id
    enum CodingKeys: String, CodingKey {
        case identifier = "id" // corrige la codingKey de identifier
        case name
        case description
        case photo
        case favorite
    }
}
