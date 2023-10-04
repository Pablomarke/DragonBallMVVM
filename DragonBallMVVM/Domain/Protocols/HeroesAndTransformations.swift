//
//  HeroesAndTransformations.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 4/10/23.
//

import Foundation

protocol HeroesAndTransformations {
    var name: String { get }
    var description: String { get }
    var id: String { get }
    var photo: URL { get }
    var favorite: Bool { get }
}
