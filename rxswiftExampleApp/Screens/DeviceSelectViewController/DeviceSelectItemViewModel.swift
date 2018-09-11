//
//  DeviceSelectItemViewModel.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/15/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift

protocol DeviceSelectItemViewModelType {
    var id: Int { get }
    var description: String { get }
    var isChecked: Bool { get }
}

class DeviceSelectItemViewModel: DeviceSelectItemViewModelType {
    var isChecked: Bool = false
    var id: Int = 0
    var description: String = ""
    
    var model: TankMainInfoViewModelType!
    
    init(with profile: DefaultProfile, and device: Device) {
        switch device.type {
        case .Engine:
            if let id = profile.modules.engineId {
                isChecked = id == device.deviceId
                self.id = id
                self.description = profile.engine.name
            }
        case .Gun:
            if let id = profile.modules.gunId {
                isChecked = id == device.deviceId
                self.id = id
                self.description = profile.gun.name
            }
        case .Suspension:
            if let id = profile.modules.suspensionId {
                isChecked = id == device.deviceId
                self.id = id
                self.description = profile.suspension.name
            }
        case .Turret:
            if let id = profile.modules.turretId {
                isChecked = id == device.deviceId
                self.id = id
                self.description = profile.turret.name
            }
        case .Radio:
            if let id = profile.modules.radioId {
                isChecked = id == device.deviceId
                self.id = id
                self.description = profile.radio.name
            }
        }
    }
    
}

