//
//  TabBarCoordinator.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 1/25/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit

@objc protocol TabBarItemCoordinatorType {
    @objc optional var rootController: UIViewController { get }
    var tabBarItem: UITabBarItem { get }
}

class MainFlowCoordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        
        start()
    }
    
    deinit {
        print("TabBarCoordinator deinit")
    }
    
    func start() {
        let navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = UIColor.green
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
        
        let tanksListNavigator = TanksListNavigator(navigationController: navigationController)
        tanksListNavigator.start()
    }
}
