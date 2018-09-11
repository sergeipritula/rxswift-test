//
//  Gun.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/12/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

protocol GunType {
    var moveDownArc: Int { get }
    var caliber: Int { get }
    var name: String { get }
    var weight: Int { get }
    var moveUpArc: Int { get }
    var fireRate: Float? { get }
    var dispersion: Double? { get }
    var tag: String { get }
    var traverseSpeed: Int { get }
    var reloadtime: Float? { get }
    var tier: Int { get }
    var aimTime: Float? { get }
}

class Gun: GunType, Decodable {
    var moveDownArc: Int
    var caliber: Int
    var name: String
    var weight: Int
    var moveUpArc: Int
    var fireRate: Float?
    var dispersion: Double?
    var tag: String
    var traverseSpeed: Int
    var reloadtime: Float?
    var tier: Int
    var aimTime: Float?
    
    private enum CodingKeys: String, CodingKey {
        case moveDownArc = "move_down_arc"
        case caliber
        case name
        case weight
        case moveUpArc = "move_up_arc"
        case fireRate = "fire_rate"
        case dispersion
        case tag
        case traverseSpeed = "traverse_speed"
        case reloadtime = "reload_time"
        case tier
        case aimTime = "aim_time"
    }
    
}
