//
//  TanksListNavigator.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/8/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit

protocol TanksListNavigatorType {
    func pushTankInfo(tankModel: TanksListItemViewModelType)
    func presentFilter(_ filterBundle: TanksFilterBundle?)
}

class TanksListNavigator: TanksListNavigatorType {
    //internal let tabBarItem: UITabBarItem = UITabBarItem(title: "Tanks", image: UIImage(named: "tank"), selectedImage: UIImage(named: "tank"))
    internal weak var rootController: UINavigationController?
    fileprivate weak var controller = kTankStoryboard.instantiateViewController(withIdentifier: "TanksListViewController") as? TanksListViewController
    
    init(navigationController: UINavigationController) {
        self.rootController = navigationController
        self.rootController?.setNavigationBarHidden(true, animated: true)
        
        controller?.viewModel = TanksListViewModel(navigator: self)
    }
    
    func start() {
        if let controller = controller {
            self.rootController?.pushViewController(controller, animated: true)
        }

    }
    
    func pushTankInfo(tankModel: TanksListItemViewModelType) {
        let navigator = TankDetailsNavigator(navigationController: rootController!, with: tankModel)
        navigator.start()
    }
    
    func presentFilter(_ filterBundle: TanksFilterBundle?) {
    
    }
    
    deinit {
        print("TanksListNavigator - deinit")
    }
    
}
