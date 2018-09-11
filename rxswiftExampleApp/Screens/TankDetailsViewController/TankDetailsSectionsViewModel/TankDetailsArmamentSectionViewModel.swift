//
//  TankDetailsArmamentSection.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/12/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift

protocol TankDefaultSectionViewModelType {
    var mainInfoItems: [TankMainInfoViewModelType] { get }
    var detailsInfoItems: [TankDetailsInfoViewModelType] { get }
}

class TankDetailsArmamentSectionViewModel: TankDefaultSectionViewModelType {
    var mainInfoItems: [TankMainInfoViewModelType] = [TankMainInfoViewModelType]()
    var detailsInfoItems: [TankDetailsInfoViewModelType] = [TankDetailsInfoViewModelType]()
    
    init(with model: TankDetailsViewModelType) {
        self.createViewModel(with: model)
    }
    
    private func createViewModel(with model: TankDetailsViewModelType) {
        if let _ = model.tankDetailsHeaderViewModel.equipment.defaultProfile.modules.gunId {
            mainInfoItems.append(TankMainInfoViewModel(with: model, and: .Gun))
        }
        
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .MaxAmmo))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .Damage))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .Penetration))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .FireRate))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .ReloadTime))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .DamagePerMinute))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .AimTime))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .TraverseSpeed))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .MoveArcUp))
        detailsInfoItems.append(TankDetailsInfoViewModel(with: model, and: .MoveArcDown))
    }
}
