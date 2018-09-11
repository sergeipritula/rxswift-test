//
//  Device.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/20/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

class Device {
    var tankId: Int
    var deviceId: Int = 0
    var name: String = ""
    var type: DeviceType
    
    init(tankId: Int, deviceId: Int, type: DeviceType) {
        self.tankId = tankId
        self.deviceId = deviceId
        self.type = type
    }
    
    init(equipment: EquipmentType, type: DeviceType) {
        self.tankId = equipment.id
        self.type = type
        
        switch  type {
        case .Engine:
            if let id = equipment.defaultProfile.modules.engineId {
                self.deviceId = id
                self.name = equipment.defaultProfile.engine.name
            }
        case .Gun:
            if let id = equipment.defaultProfile.modules.gunId {
                self.deviceId = id
                self.name = equipment.defaultProfile.gun.name
            }
        case .Radio:
            if let id = equipment.defaultProfile.modules.radioId {
                self.deviceId = id
                self.name = equipment.defaultProfile.radio.name
            }
        case .Suspension:
            if let id = equipment.defaultProfile.modules.suspensionId {
                self.deviceId = id
                self.name = equipment.defaultProfile.suspension.name
            }
        case .Turret:
            if let id = equipment.defaultProfile.modules.turretId {
                self.deviceId = id
                self.name = equipment.defaultProfile.turret.name
            }
        }
    }
    
    init(device: Device) {
        self.tankId = device.tankId
        self.deviceId = device.deviceId
        self.type = device.type
    }
}
