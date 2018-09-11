//
//  NewTankDetailsNavigator.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/9/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit

protocol TankDetailsNavigatorType {
    func presentAvailableDevices(with model: TankMainInfoViewModelType)
    func presentDeviceInfo(with model: TankMainInfoViewModelType)
    func presentTanksRatingList(with model: TankDetailsInfoViewModelType)
    
    func dissmis()
}

class TankDetailsNavigator: TankDetailsNavigatorType {
    internal weak var navigationController: UINavigationController?
    fileprivate weak var controller = kTankStoryboard.instantiateViewController(withIdentifier: "TankDetailsViewController") as? TankDetailsViewController
    
    init(navigationController: UINavigationController, with model: TanksListItemViewModelType) {
        self.navigationController = navigationController
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.controller?.title = model.equipment.name
        self.controller?.viewModel = TankDetailsViewModel(navigator: self, with: model)
    }
    
    init(navigationController: UINavigationController, with model: TanksCardListItemViewModelType) {
        self.navigationController = navigationController
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.controller?.title = model.equipment.name

        let itemModel = TanksListItemViewModel(with: model.equipment)
        self.controller?.viewModel = TankDetailsViewModel(navigator: self, with: itemModel)
    }
    
    func start() {
        if let controller = controller {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func presentDeviceInfo(with model: TankMainInfoViewModelType) {
        let navigator = InfoModalPopupNavigator(navigationController: navigationController!, with: model)
        navigator.present()
    }
    
    func presentAvailableDevices(with model: TankMainInfoViewModelType) {
        let navigator = DeviceSelectNavigator(navigationController: navigationController!, with: model)
        navigator.transition = self
        navigator.present()
    }
    
    func presentTanksRatingList(with model: TankDetailsInfoViewModelType) {
        let navigator = TanksRatingListNavigator(navigationController: navigationController!, with: model)
        navigator.start()
    }
    
    func dissmis() {
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("TankDetailsNavigator - deinit")
    }
    
}

extension TankDetailsNavigator: SelectDeviceTransitionsProtocol {
    func selected(configuration: ModulesConfiguration) {
        controller!.viewModel.tankDetailsHeaderViewModel.setCustomModulesConfiguration(with: configuration)
    }
    
}
