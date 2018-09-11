//
//  TanksRatingListNavigator.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/20/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit

protocol TanksRatingListNavigatorType {
    func presentTankDetails(with equipment: EquipmentType)
    func dismiss()
}

class TanksRatingListNavigator: TanksRatingListNavigatorType {
    internal weak var navigationController: UINavigationController?
    fileprivate weak var controller = kTankStoryboard.instantiateViewController(withIdentifier: "TanksRatingListViewController") as? TanksRatingListViewController
    
    init(navigationController: UINavigationController, with model: TankDetailsInfoViewModelType) {
        self.navigationController = navigationController
        self.controller?.viewModel = TanksRatingListViewModel(navigator: self, with: model)
    }
    
    func start() {
        if let controller = controller {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func presentTankDetails(with equipment: EquipmentType) {
        let model = TanksListItemViewModel(with: equipment)
        
        let navigator = TankDetailsNavigator(navigationController: navigationController!, with: model)
        navigator.start()
    }
    
    func dismiss() {
        controller?.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("TanksRatingListNavigator - deinit")
    }
    
}
