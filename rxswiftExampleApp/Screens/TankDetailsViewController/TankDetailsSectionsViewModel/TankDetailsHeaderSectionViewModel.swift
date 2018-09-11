//
//  NewTankDetailsViewModel.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/9/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

enum ConfigurationVersion {
    case Base
    case Advanced
    
    static func supportsConfigurationChange(equipment: EquipmentType) -> ConfigurationVersion {
        if equipment.engines.count <= 1 && equipment.guns.count <= 1 && equipment.turrets.count <= 1 && equipment.suspensions.count <= 1 && equipment.radios.count <= 1 {
            return .Advanced
        } else {
            return .Base
        }
    }
}

protocol TankDetailsHeaderSectionViewModelType {
    var name: String { get }
    var nation: String { get }
    var type: String { get }
    var tier: String { get }
    var isPremium: Bool { get }
    var price: Int { get }
    var nationImage: UIImage? { get }
    var tankTypeImage: UIImage? { get }
    var viewModel: TankDetailsViewModelType { get set}
    var supportConfigurationChanges: Bool { get }
    var tankImage: PublishSubject<UIImage> { get }
}

class TankDetailsHeaderSectionViewModel: TankDetailsHeaderSectionViewModelType {
    var price: Int = 0
    var supportConfigurationChanges: Bool = false
    var name: String
    var nation: String
    var type: String
    var tier: String
    var isPremium: Bool
    
    var nationImage: UIImage?
    var tankTypeImage: UIImage?
    var tankImage: PublishSubject<UIImage> = PublishSubject<UIImage>()
    
    var equipment: EquipmentType
    var viewModel: TankDetailsViewModelType
    
    init(with model: TankDetailsViewModelType) {
        self.viewModel = model
        self.equipment = model.tankDetailsHeaderViewModel.equipment
        
        self.name = equipment.name
        self.nation = equipment.nation
        self.type = equipment.type
        self.tier = String(equipment.tier).getRomanianNumber
        self.isPremium = equipment.isPremium
        self.nationImage = UIImage(named: equipment.nation)
        self.tankTypeImage = UIImage(named: "tank\(equipment.type)")
        
        if equipment.isPremium {
            if let price = equipment.priceGold {
                self.price = price
            }
        } else {
            if let price = equipment.priceCredit {
                self.price = price
            }
        }
        
        if let imageUrl = equipment.images.bigIcon  {
            Alamofire.request(imageUrl).responseData { [weak self] response in
                guard let `self` = self else { return }
                
                if let data = response.data, let img = UIImage(data: data, scale: 1) {
                    self.tankImage.onNext(img)
                } else {
                    guard let error = response.error else {
                        return
                    }
                    self.tankImage.onError(error)
                }
            }
        }
    }
    
}
