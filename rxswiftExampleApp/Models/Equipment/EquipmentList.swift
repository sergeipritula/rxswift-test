//
//  EquipmentList.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 1/31/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

class EquipmentList: Decodable {
    var status: String = ""
    var meta: Meta
    var data: [String: Equipment]
    
    private enum CodingKeys: String, CodingKey {
        case status
        case meta
        case data
    }
}

