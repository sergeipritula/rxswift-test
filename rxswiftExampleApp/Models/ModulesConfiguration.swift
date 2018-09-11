//
//  SelectedConfiguration.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/16/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

class ModulesConfiguration {
    var tankId: Int
    var modules: Modules
    var supportAdvancedConfiguration: Bool = false
    
    init(with equipment: EquipmentType) {
        self.tankId = equipment.id
        self.modules = equipment.defaultProfile.modules
        
        let version = ConfigurationVersion.supportsConfigurationChange(equipment: equipment)
        
        switch version {
        case .Base:
            self.supportAdvancedConfiguration = true
        case .Advanced:
            self.supportAdvancedConfiguration = false
        }
    }
    
    init(id: Int, modules: Modules) {
        self.tankId = id
        self.modules = modules
    }
    
    func changeModules(with modules: Modules) {
        self.modules = modules
    }
    
}
