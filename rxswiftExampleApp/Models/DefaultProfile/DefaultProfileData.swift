//
//  DefaultProfileData.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/15/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

class DefaultProfileData: Decodable {
    var status: String = ""
    var data: [String: DefaultProfile] 
    
    private enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}


