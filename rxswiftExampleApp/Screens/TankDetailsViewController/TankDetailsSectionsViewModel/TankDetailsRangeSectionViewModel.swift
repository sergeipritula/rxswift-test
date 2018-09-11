//
//  TankDetailsRangeSection.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/13/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift

class TankDetailsRangeSectionViewModel: TankDefaultSectionViewModelType {
    var mainInfoItems: [TankMainInfoViewModelType] = [TankMainInfoViewModelType]()
    var detailsInfoItems: [TankDetailsInfoViewModelType] = [TankDetailsInfoViewModelType]()
    
    init(with model: TankDetailsViewModelType) {
        self.createViewModel(with: model)
    }
    
    private func createViewModel(with model: TankDetailsViewModelType) {
        if let _ = model.tankDetailsHeaderViewModel.equipment.defaultProfile.modules.turretId {
            mainInfoItems.append(TankMainInfoViewModel(with: model, and: .Turret))
        }
        
        if let _ = model.tankDetailsHeaderViewModel.equipment.defaultProfile.modules.radioId {
            mainInfoItems.append(TankMainInfoViewModel(with: model, and: .Radio))
        }
        
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .Range))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .SignalRange))
    }
}
