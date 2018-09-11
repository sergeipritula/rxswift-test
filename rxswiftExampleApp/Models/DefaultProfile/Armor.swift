//
//  Armor.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/12/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

protocol ArmorType {
    var turret: TurretAdditions? { get }
    var hull: Hull? { get }
}

class Armor: ArmorType, Decodable {
    var turret: TurretAdditions?
    var hull: Hull?
    
    private enum CondingKeys: String, CodingKey {
        case turret
        case hull
    }
}
