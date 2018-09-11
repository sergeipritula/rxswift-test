//
//  Meta.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 1/31/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

protocol MetaType {
    var count: Int { get }
    var pageTotal: Int { get }
    var total: Int { get }
    var limit: Int { get }
    var page: Int? { get }
}

class Meta: MetaType, Decodable {
    var count: Int
    var pageTotal: Int
    var total: Int
    var limit: Int
    var page: Int?
    
    private enum CodingKeys: String, CodingKey {
        case pageTotal = "page_total"
        case count
        case total
        case limit
        case page
    }
}
