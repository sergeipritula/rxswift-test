//
//  DeviceSelectNavigator.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/15/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit

protocol SelectDeviceTransitionsProtocol {
    func selected(configuration: ModulesConfiguration)
}

protocol DeviceSelectNavigatorType: SelectDeviceTransitionsProtocol {
    func present()
    func dismiss()
}

class DeviceSelectNavigator: DeviceSelectNavigatorType {
    internal weak var navigationController: UINavigationController?
    fileprivate weak var controller = kTankStoryboard.instantiateViewController(withIdentifier: "DeviceSelectViewController") as? DeviceSelectViewController
    var transition: SelectDeviceTransitionsProtocol!
    
    init(navigationController: UINavigationController, with model: TankMainInfoViewModelType) {
        self.navigationController = navigationController
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.controller?.viewModel = DeviceSelectViewModel(navigator: self, with: model)
    }
    
    func present() {
        let navController = UINavigationController(rootViewController: controller!)
        navController.setNavigationBarHidden(true, animated: false)
        navController.modalPresentationStyle = .overCurrentContext
        navController.modalTransitionStyle = .crossDissolve
        self.controller!.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.controller!.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func selected(configuration: ModulesConfiguration) {
        transition.selected(configuration: configuration)
        dismiss()
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.controller?.dismiss(animated: true, completion: nil)
        }
    }
    
    deinit {
        print("DeviceSelectNavigator - deinit")
    }
}
