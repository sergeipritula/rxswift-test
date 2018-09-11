//
//  Turret.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/12/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

protocol TurretAddiotionsType {
    var front: Int { get }
    var sides: Int { get }
    var rear: Int { get }
}

class TurretAdditions: TurretAddiotionsType, Decodable {
    var front: Int
    var sides: Int
    var rear: Int
    
    private enum CondingKeys: String, CodingKey {
        case front
        case sides
        case rear
    }
}
