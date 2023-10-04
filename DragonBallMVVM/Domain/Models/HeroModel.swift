//
//  HeroModel.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 4/10/23.
//

import Foundation

struct Hero: Decodable {
    let id, description, name : String
    let photo: URL
    let favorite: Bool
}

extension Hero: HeroesAndTransformations {
    
}
