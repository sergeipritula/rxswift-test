//
//  Turret.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/12/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

protocol TurretType {
    var name: String { get }
    var weight: Int { get }
    var viewRange: Int? { get }
    var hp: Int { get }
    var tag: String { get }
    var traverseSpeed: Int? { get }
    var traverseRightArc: Int? { get }
    var traverseLeftArc: Int? { get }
    var tier: Int { get }
}

class Turret: TurretType, Decodable {
    var name: String
    var weight: Int
    var viewRange: Int?
    var hp: Int
    var tag: String
    var traverseSpeed: Int?
    var traverseRightArc: Int?
    var traverseLeftArc: Int?
    var tier: Int
    
    
    private enum CodingKeys: String, CodingKey {
        case name
        case weight
        case viewRange = "view_range"
        case hp
        case tag
        case traverseSpeed = "traverse_speed"
        case traverseRightArc = "traverse_right_arc"
        case traverseLeftArc = "traverse_left_arc"
        case tier
    }
    
}
