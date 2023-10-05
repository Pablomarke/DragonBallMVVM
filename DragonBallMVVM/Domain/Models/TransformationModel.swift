//
//  TransformationModel.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 4/10/23.
//

import Foundation

struct Transformation: Decodable {
    let name, id, description : String
    let photo: URL
}

extension Transformation: HeroesAndTransformations{
    var favorite: Bool {
        return false
    }
}
