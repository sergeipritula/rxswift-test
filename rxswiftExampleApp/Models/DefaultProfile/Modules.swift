//
//  Modules.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/12/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

protocol ModulesType {
    var gunId: Int? { get }
    var suspensionId: Int? { get }
    var turretId: Int? { get }
    var radioId: Int? { get }
    var engineId: Int? { get }
}

class Modules: ModulesType, Decodable {
    var gunId: Int?
    var suspensionId: Int?
    var turretId: Int?
    var radioId: Int?
    var engineId: Int?
    
    private enum CodingKeys: String, CodingKey {
        case gunId = "gun_id"
        case suspensionId = "suspension_id"
        case turretId = "turret_id"
        case radioId = "radio_id"
        case engineId = "engine_id"
    }
}

extension Modules {
    convenience init(with device: Device) {
        self.init()
        
        switch device.type {
        case .Gun:
            self.gunId = device.deviceId
        case .Engine:
            self.engineId = device.deviceId
        case .Turret:
            self.turretId = device.deviceId
        case .Suspension:
            self.suspensionId = device.deviceId
        case .Radio:
            self.radioId = device.deviceId
        }
    }
}
