//
//  TankDetails.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/9/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

protocol TankDetailsType {
    var id: String { get }
}

class TankDetails: Decodable, TankDetailsType {
    var id: String
    
    private enum CodingKeys: String, CodingKey {
        case id
    }
}
