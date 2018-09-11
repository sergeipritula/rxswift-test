//
//  InfoModalPopupViewModel.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/14/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol InfoModalPopupViewModelType {
    var profile: PublishSubject<DefaultProfile?> { get }
    var device: Device { get }
    
    func dismiss()
}

class InfoModalPopupViewModel: InfoModalPopupViewModelType {
    var profile: PublishSubject<DefaultProfile?> = PublishSubject<DefaultProfile?>()
    
    private var navigator: InfoModalPopupNavigator!
    private var dataProvider: AlamofireVehicleCharacteristicDataProvider!
    
    private let disposeBag = DisposeBag()
    internal var device: Device
    
    init(navigator: InfoModalPopupNavigator, with model: TankMainInfoViewModelType) {
        self.navigator = navigator
        self.dataProvider = AlamofireVehicleCharacteristicDataProvider()
        
        self.device = model.device
        self.dataProvider.configuration = ModulesConfiguration(id: device.tankId, modules: Modules(with: device))
        
        self.loadDeviceInfo()
    }
    
    private func loadDeviceInfo() {
        dataProvider.getProfile().asObservable()
            .subscribe(onNext: { [weak self] profile in
                self?.profile.onNext(profile)
            }).disposed(by: disposeBag)
    }
    
    func dismiss() {
        self.navigator.dismiss()
    }
    
}
