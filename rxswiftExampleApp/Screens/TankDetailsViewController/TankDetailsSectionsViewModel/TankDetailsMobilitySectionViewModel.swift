//
//  TankDetailsMobilitySection.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/13/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift

class TankDetailsMobilitySectionViewModel: TankDefaultSectionViewModelType {
    var mainInfoItems: [TankMainInfoViewModelType] = [TankMainInfoViewModelType]()
    var detailsInfoItems: [TankDetailsInfoViewModelType] = [TankDetailsInfoViewModelType]()
    
    init(with model: TankDetailsViewModelType) {
        self.createViewModel(with: model)
    }
    
    private func createViewModel(with model: TankDetailsViewModelType) {
        if let _ = model.tankDetailsHeaderViewModel.equipment.defaultProfile.modules.engineId {
            mainInfoItems.append(TankMainInfoViewModel(with: model, and: .Engine))
        }
        
        if let _ = model.tankDetailsHeaderViewModel.equipment.defaultProfile.modules.suspensionId {
            mainInfoItems.append(TankMainInfoViewModel(with: model, and: .Suspension))
        }
        
        if let _ = model.tankDetailsHeaderViewModel.equipment.defaultProfile.modules.turretId {
            mainInfoItems.append(TankMainInfoViewModel(with: model, and: .Turret))
        }
        
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .EnginePower))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .MaxSpeed))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .TraverseSpeed))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .TurretToolSpeed ))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .MaxWeight))
    }
}
