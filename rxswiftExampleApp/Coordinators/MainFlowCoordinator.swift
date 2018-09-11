//
//  TabBarCoordinator.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 1/25/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit

class MainFlowCoordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        
        start()
    }
    
    func start() {
        let navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = UIColor(hex: 0x0E2814)
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
        
        let tanksListNavigator = TanksListNavigator(navigationController: navigationController)
        tanksListNavigator.start()
    }
    
    deinit {
        print("MainFlowCoordinator - deinit")
    }
    
}
