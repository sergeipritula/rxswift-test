//
//  VehicleListDataProvider.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/20/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

class VehicleListDataProvider {
    typealias VehicleCompletionType = (VehicleFunctionDataResult) -> ()
    private let request: VehicleCharacteristicRequest!
    private var devices = [Device]()
    
    init(model: TankMainInfoViewModelType) {
        request = VehicleCharacteristicRequest(model: model)
        create(from : model)
    }
    
    init(configuration: ModulesConfiguration?) {
        request = VehicleCharacteristicRequest(configuration: configuration)
    }
    
    func create(from model: TankMainInfoViewModelType) {
        switch model.device.type {
        case .Engine:
            model.equipment.engines.forEach({
                devices.append(Device(tankId: model.equipment.id, deviceId: $0, type: model.device.type))
            })
        case .Gun:
            model.equipment.guns.forEach({
                devices.append(Device(tankId: model.equipment.id, deviceId: $0, type: model.device.type))
            })
        case .Suspension:
            model.equipment.suspensions.forEach({
                devices.append(Device(tankId: model.equipment.id, deviceId: $0, type: model.device.type))
            })
        case .Turret:
            model.equipment.turrets.forEach({
                devices.append(Device(tankId: model.equipment.id, deviceId: $0, type: model.device.type))
            })
        case .Radio:
            model.equipment.radios.forEach({
                devices.append(Device(tankId: model.equipment.id, deviceId: $0, type: model.device.type))
            })
        }
    }
    
    func load(completion: @escaping VehicleCompletionType) {
        for device in devices {
            request.execute(device: device, completion: completion)
        }
    }
    
}
