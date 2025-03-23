//
//  HeroDTOToHeroModelMapper.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 22/3/25.
//

/// Transforma un HeroDTO a un HeroModel. Traduce el modelo de la capa de datos al del dominio
final class HeroDTOToHeroModelMapper {
    func map(_ dto:HeroDTO) -> HeroModel {
        HeroModel(identifier: dto.identifier,
                  name: dto.name,
                  description: dto.description,
                  photo: dto.photo,
                  favorite: dto.favorite)
    }
}
