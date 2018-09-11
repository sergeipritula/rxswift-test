//
//  GunProperties.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/13/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

class GunProperties {
    var penetration: [Int] = []
    var damage: [Int] = []
    
    init(data: [Ammo]) {
        if let data = data.first(where: { $0.type == "ARMOR_PIERCING" }) {
            self.penetration = data.penetration
            self.damage = data.damage
        } else {
            if let data = data.first {
                self.penetration = data.penetration
                self.damage = data.damage
            }
        }
    }
    
    func getProperties() -> (penetration: Float, damage: Float)? {
        if damage.count >= 2 && penetration.count >= 2 {
            return (Float(penetration[1]), Float(damage[1]))
        }
        
        return nil
    }
}
