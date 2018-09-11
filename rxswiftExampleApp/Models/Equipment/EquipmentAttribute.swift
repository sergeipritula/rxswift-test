//
//  EquipmentAttribute.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/1/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

protocol EquipmentAttribute {
    var id: Int { get }
    var name: String { get }
}

struct TankType: EquipmentAttribute, Decodable {
    var id: Int
    var name: String
    
    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
}

struct TierType: EquipmentAttribute, Codable {
    var id: Int
    var name: String
}

struct NationType: EquipmentAttribute, Codable {
    
    var id: Int
    var name: String
    
    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
}


enum AttributeType{
    case tankType
    case nationType
    case tierType
}

