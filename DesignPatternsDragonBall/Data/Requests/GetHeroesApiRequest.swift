//
//  GetHeroesApiRequest.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 22/3/25.
//

import Foundation

struct GetHeroesAPIRequest: HTTPRequest {
    typealias Response = [HeroDTO]
    
    let method: Methods = .POST
    let path: String = "/api/heros/all"
    let body: (any Encodable)?
    
    init(name: String = "") {
        body = RequestDTO(name: name) // Si lo inicializamos con un nombre, este será el body que enviemos. Solo se llamará a la función cuando haya un valor dentro de la variable
        
    }
}

private extension GetHeroesAPIRequest {
    struct RequestDTO: Codable {
        let name: String
    }
}
