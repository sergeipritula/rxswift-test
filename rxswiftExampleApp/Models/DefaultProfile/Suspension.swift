//
//  Suspension.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/12/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

protocol SuspensionType {
    var name: String { get }
    var weight: Int { get }
    var load_limit: Int? { get }
    var tag: String { get }
    var traverse_speed: Int? { get }
    var tier: Int { get }
}

class Suspension: SuspensionType, Decodable {
    var name: String
    var weight: Int
    var load_limit: Int?
    var tag: String
    var traverse_speed: Int?
    var tier: Int
    
    private enum CodingKeys: String, CodingKey {
        case name
        case weight
        case load_limit = "load_limit"
        case tag
        case traverse_speed = "traverse_speed"
        case tier
    }
}
