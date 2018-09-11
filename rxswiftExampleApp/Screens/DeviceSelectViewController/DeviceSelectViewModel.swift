//
//  DeviceSelectViewModel.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/15/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift

protocol DeviceSelectViewModelType {
    var items: [DeviceSelectItemViewModelType] { get }
    var itemsObserver: PublishSubject<[DeviceSelectItemViewModelType]> { get }
    var profile: DefaultProfile { get }
    var device: Device { get }
    
    func select(with model: DeviceSelectItemViewModelType)
    func dismiss()
}

class DeviceSelectViewModel: DeviceSelectViewModelType {
    internal var itemsObserver: PublishSubject<[DeviceSelectItemViewModelType]> = PublishSubject<[DeviceSelectItemViewModelType]>()
    internal var items: [DeviceSelectItemViewModelType] = []
    
    internal var profile: DefaultProfile
    internal var device: Device
    
    private var dataProvider: VehicleListDataProvider
    private var navigator: DeviceSelectNavigatorType
    private var disposeBag = DisposeBag()
    
    init(navigator: DeviceSelectNavigatorType, with model: TankMainInfoViewModelType) {
        self.dataProvider = VehicleListDataProvider(model: model)
        self.navigator = navigator
        
        self.profile = model.equipment.defaultProfile
        self.device = model.device
        
        self.loadItems()
    }
    
    private func loadItems() {
        dataProvider.load { [weak self] result in
            switch result {
            case .result(let profile):
                self?.createItemModel(with: profile)
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func createItemModel(with profile: DefaultProfile) {
        self.items.append(DeviceSelectItemViewModel(with: profile, and: device))
        itemsObserver.onNext(self.items)
    }
    
    func select(with model: DeviceSelectItemViewModelType) {
        if model.isChecked {
            self.navigator.dismiss()
            return
        }
        
        let modules = profile.modules
        
        switch  device.type {
        case .Engine:
            modules.engineId = model.id
        case .Gun:
            modules.gunId = model.id
        case .Turret:
            modules.turretId = model.id
        case .Suspension:
            modules.suspensionId = model.id
        case .Radio:
            modules.radioId = model.id
        }
        
        self.navigator.selected(configuration: ModulesConfiguration(id: device.tankId, modules: modules))
    }
    
    func dismiss() {
        self.navigator.dismiss()
    }
}
