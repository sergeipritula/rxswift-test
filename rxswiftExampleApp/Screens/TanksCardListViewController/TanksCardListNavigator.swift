//
//  TanksCardListNavigator.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 3/6/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit

protocol TanksCardListNavigatorType {
    func pushTankInfo(tankModel: TanksCardListItemViewModelType)
}

class TanksCardListNavigator: TanksCardListNavigatorType {
    internal let tabBarItem: UITabBarItem = UITabBarItem(title: "Tanks", image: UIImage(named: "tank"), selectedImage: UIImage(named: "tank"))
    internal weak var rootController = kTankStoryboard.instantiateViewController(withIdentifier: "homeNav") as? UINavigationController
    fileprivate weak var controller = kTankStoryboard.instantiateViewController(withIdentifier: "TanksCardListViewController") as? TanksCardListViewController
    
    init() {
        controller?.viewModel = TanksCardListViewModel(navigator: self)
    }
    
    func start() {
        rootController?.tabBarItem = tabBarItem
        rootController?.navigationBar.tintColor = .black
        rootController?.viewControllers = [controller!]
    }
    
    func pushTankInfo(tankModel: TanksCardListItemViewModelType) {
        let navigator = TankDetailsNavigator(navigationController: rootController!, with: tankModel)
        navigator.start()
    }
    
    deinit {
        print("TanksCardListViewController - deinit")
    }
}
