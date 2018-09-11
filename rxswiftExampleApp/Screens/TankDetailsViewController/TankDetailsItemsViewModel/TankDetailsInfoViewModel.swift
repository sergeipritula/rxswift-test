//
//  TankDetailsInfoModel.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/13/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

protocol TankDetailsInfoViewModelType {
    var property: PropertyCharacteristic { get }
    var viewModel: TankDetailsViewModelType! { get }
    func pushTanksInfo(with model: TankDetailsInfoViewModelType)
}

class TankDetailsInfoViewModel: TankDetailsInfoViewModelType {
    var property: PropertyCharacteristic
    var viewModel: TankDetailsViewModelType!
    
    init(with model: TankDetailsViewModelType, and type: PropertiesType) {
        self.viewModel = model
        self.property = PropertyCharacteristic(with: model.tankDetailsHeaderViewModel.equipment, and: type)
        
        if let value = self.viewModel.tankDetailsHeaderViewModel.characteristics.first(where: { (chars) -> Bool in chars[0].type == type })?.first(where:
                { (char) -> Bool in char.equipment.id == model.tankDetailsHeaderViewModel.equipment.id }) {
            self.property.upperValue = value.upperValue
        }
    }
    
    func pushTanksInfo(with model: TankDetailsInfoViewModelType) {
        self.viewModel.presentTanksRatingsList(with: self)
    }
    
}

