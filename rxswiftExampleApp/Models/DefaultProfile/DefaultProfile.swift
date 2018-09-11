//
//  DefaultProfile.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/12/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

protocol DefaultProfileType {
    var maxAmmo: Int { get }
    var weight: Int { get }
    var hp: Int { get }
    var hullWeight: Int { get }
    var speedForward: Int { get }
    var speedBacward: Int { get }
    var hullHp: Int { get }
    var maxWeight: Int { get }
    var engine: Engine { get }
    var suspension: Suspension { get }
    var armor: Armor { get }
    var modules: Modules { get }
    var gun: Gun { get }
    var turret: Turret { get }
    var radio: Radio { get }
    var ammo: [Ammo] { get }
    var isDefault: Bool? { get }
}

class DefaultProfile: DefaultProfileType, Decodable {
    var maxAmmo: Int
    var weight: Int
    var hp: Int
    var hullWeight: Int
    var speedForward: Int
    var speedBacward: Int
    var hullHp: Int
    var maxWeight: Int
    var engine: Engine
    var suspension: Suspension
    var armor: Armor
    var modules: Modules
    var gun: Gun
    var turret: Turret
    var radio: Radio
    var ammo: [Ammo]
    var isDefault: Bool?

    private enum CodingKeys: String, CodingKey {
        case maxAmmo = "max_ammo"
        case hullWeight = "hull_weight"
        case speedForward = "speed_forward"
        case speedBacward = "speed_backward"
        case hullHp = "hull_hp"
        case maxWeight = "max_weight"
        case isDefault = "is_default"
        case weight
        case hp
        case engine
        case suspension
        case armor
        case modules
        case gun
        case turret
        case radio
        case ammo
    }
}
