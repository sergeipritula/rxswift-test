//
//  TankDetailsArmorSection.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/12/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift

class TankDetailsArmorSectionViewModel: TankDefaultSectionViewModelType {
    var mainInfoItems: [TankMainInfoViewModelType] = [TankMainInfoViewModelType]()
    var detailsInfoItems: [TankDetailsInfoViewModelType] = [TankDetailsInfoViewModelType]()
    
    init(with model: TankDetailsViewModelType) {
        self.createViewModel(with: model)
        self.bind()
    }
    
    private func createViewModel(with model: TankDetailsViewModelType) {
        if let _ = model.tankDetailsHeaderViewModel.equipment.defaultProfile.modules.turretId {
            mainInfoItems.append(TankMainInfoViewModel(with: model, and: .Turret))
        }
        
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .MinStrength))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .TurretFront))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .TurretSides))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .TurretRear))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .HullFront))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .HullSides))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .HullRear))
    }
    
    func bind() {
        
    }
}
