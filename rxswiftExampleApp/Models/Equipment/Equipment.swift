//
//  У.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 1/31/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

protocol EquipmentType {
    var id: Int { get }
    var isPremium: Bool { get }
    var images: Images { get }
    var type: String { get }
    var tag: String { get }
    var descriptionTitle: String { get }
    var name: String { get }
    var shortName: String { get }
    var nation: String { get }
    var tier: Int { get }
    var priceGold: Int? { get }
    var priceCredit: Int? { get }
    var guns: [Int] { get }
    var radios: [Int] { get }
    var suspensions: [Int] { get }
    var provisions: [Int] { get }
    var engines: [Int] { get }
    var turrets: [Int] { get }
    var defaultProfile: DefaultProfile { get set }
}

class Equipment: EquipmentType, Decodable {
    var id: Int
    var isPremium: Bool
    var images: Images
    var type: String
    var tag: String
    var descriptionTitle: String
    var name: String
    var shortName: String
    var nation: String
    var tier: Int
    var priceGold: Int?
    var priceCredit: Int?
    var guns: [Int]
    var radios: [Int]
    var suspensions: [Int]
    var provisions: [Int]
    var engines: [Int]
    var turrets: [Int]
    var defaultProfile: DefaultProfile
    
    enum CodingKeys: String, CodingKey {
        case id = "tank_id"
        case isPremium = "is_premium"
        case priceGold = "price_gold"
        case priceCredit = "price_credit"
        case descriptionTitle = "description"
        case defaultProfile = "default_profile"
        case shortName = "short_name"
        case images
        case type
        case tag
        case name
        case nation
        case tier
        case guns
        case radios
        case suspensions
        case provisions
        case engines
        case turrets
    }
}
