//
//  Radio.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/12/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

protocol RadioType {
    var tier: Int { get }
    var signalRange: Int { get }
    var tag: String { get }
    var name: String { get }
    var weight: Int { get }
}

class Radio: RadioType, Decodable {
    var tier: Int
    var signalRange: Int
    var tag: String
    var name: String
    var weight: Int
    
    private enum CodingKeys: String, CodingKey {
        case tier
        case signalRange = "signal_range"
        case tag 
        case name
        case weight
    }
    
}
