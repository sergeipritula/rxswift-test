//
//  Ammo.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/12/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

protocol AmmoType {
    var penetration: [Int] { get }
    var type: String { get }
    var damage: [Int] { get}
}

class Ammo: AmmoType, Decodable {
    var penetration: [Int]
    var type: String
    var damage: [Int]
    
    private enum CodingKeys: String, CodingKey {
        case penetration
        case type
        case damage
    }
    
}
