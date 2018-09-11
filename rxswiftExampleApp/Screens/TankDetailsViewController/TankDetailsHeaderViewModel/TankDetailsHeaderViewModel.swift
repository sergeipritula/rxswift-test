//
//  TankDetailsHeaderViewModel.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 3/2/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol TankDetailsHeaderViewModelType {
    var equipment: EquipmentType { get }
    
    var selectedConfiguration: ModulesConfiguration { get }
    var configurationVersion: ConfigurationVersion { get }
    
    var equipmentSubject: PublishSubject<EquipmentType> { get }
    var configurationVersionSubject: PublishSubject<ConfigurationVersion> { get }
    
    var tankImage: UIImage? { get }
    
    var characteristics: [[PropertyCharacteristic]] { get set }
    
    func initCharacteristics(with characteristics: [[PropertyCharacteristic]])
    
    func updateEquipment(with equipment: EquipmentType)
    func changeProfile(with profile: DefaultProfile)
    
    func setCustomModulesConfiguration(with coonfiguration: ModulesConfiguration)
    func changeConfiguration(with version: ConfigurationVersion)
}

class TankDetailsHeaderViewModel: TankDetailsHeaderViewModelType {
    var equipment: EquipmentType
    
    var selectedConfiguration: ModulesConfiguration
    var configurationVersion: ConfigurationVersion
    
    var equipmentSubject = PublishSubject<EquipmentType>()
    var configurationVersionSubject = PublishSubject<ConfigurationVersion>()
    
    var tankImage: UIImage?
    
    var characteristics = [[PropertyCharacteristic]]()
    
    init(with model: TanksListItemViewModelType) {
        self.equipment = model.equipment
        self.selectedConfiguration = ModulesConfiguration(with: model.equipment)
        
        if self.selectedConfiguration.supportAdvancedConfiguration {
            self.configurationVersion = .Base
        } else {
            self.configurationVersion = .Advanced
        }
        
        if let image = model.tankImage.value {
            self.tankImage = image
        } else {
            if let imageUrl = model.equipment.images.bigIcon  {
                Alamofire.request(imageUrl).responseData {[weak self] response in
                    guard let `self` = self else { return }
                    
                    if response.error == nil, let data = response.data, let img = UIImage(data: data, scale: 1) {
                        self.tankImage = img
                    } else {
                        self.tankImage = nil
                    }
                }
            }
        }
    }
    
    func initCharacteristics(with characteristics: [[PropertyCharacteristic]]) {
        self.characteristics = characteristics
    }
    
    func updateEquipment(with equipment: EquipmentType) {
        self.equipment = equipment
        self.equipmentSubject.onNext(self.equipment)
    }
    
    func changeProfile(with profile: DefaultProfile) {
        self.equipment.defaultProfile = profile
        self.equipmentSubject.onNext(self.equipment)
    }
    
    func setCustomModulesConfiguration(with configuration: ModulesConfiguration) {
        self.selectedConfiguration = configuration
        self.configurationVersion = .Base
        self.configurationVersionSubject.onNext(configurationVersion)
    }
    
    func changeConfiguration(with version: ConfigurationVersion) {
        let modules = Modules()
        
        modules.engineId = (version == .Base ? equipment.engines.min() : equipment.engines.max())
        modules.gunId = (version == .Base ? equipment.guns.min() : equipment.guns.max())
        modules.suspensionId = (version == .Base ? equipment.suspensions.min() : equipment.suspensions.max())
        modules.turretId = (version == .Base ? equipment.turrets.min() : equipment.turrets.max())
        modules.radioId = (version == .Base ? equipment.radios.min() : equipment.radios.max())
        
        self.selectedConfiguration.changeModules(with: modules)
        self.configurationVersion = version
        self.configurationVersionSubject.onNext(self.configurationVersion)
    }
}
