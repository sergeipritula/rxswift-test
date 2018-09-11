//
//  Engine.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/12/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

protocol EngineType {
    var name: String { get }
    var power: Int { get }
    var weight: Int { get }
    var tag: String { get }
    var tier: Int { get }
    var fire_chance: Float? { get }
}

class Engine: EngineType, Decodable {
    var name: String
    var power: Int
    var weight: Int
    var tag: String
    var tier: Int
    var fire_chance: Float?
    
    private enum CodingKeys: String, CodingKey {
        case fire_chance = "fire_chance"
        case name
        case power
        case weight
        case tag
        case tier
    }
}
