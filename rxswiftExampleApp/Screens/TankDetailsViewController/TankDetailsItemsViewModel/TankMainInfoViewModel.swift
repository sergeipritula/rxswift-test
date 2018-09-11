//
//  TankMainInfoModel.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/13/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit

public enum DeviceType: String {
    case Gun = "Gun"
    case Turret = "Turret"
    case Engine = "Engine"
    case Suspension = "Suspension"
    case Radio = "Radio"
}

protocol InfoModelProtocol {
    var device: Device { get }
    var equipment: EquipmentType { get }
}

protocol TankMainInfoViewModelType: InfoModelProtocol {
    var iconImage: UIImage? { get }
    
    func pushDeviceInfo()
}

class TankMainInfoViewModel: TankMainInfoViewModelType {
    var device: Device
    var equipment: EquipmentType
    var iconImage: UIImage?
    
    var viewModel: TankDetailsViewModelType!
    
    init(with model: TankDetailsViewModelType, and type: DeviceType) {
        self.device = Device(equipment: model.tankDetailsHeaderViewModel.equipment, type: type)
        
        if let image = UIImage(named: type.rawValue) {
            self.iconImage = image
        }
        
        self.equipment = model.tankDetailsHeaderViewModel.equipment
        self.viewModel = model
    }
    
    func pushDeviceInfo() {
        self.viewModel.presentDeviceInfo(with: self)
    }
}
