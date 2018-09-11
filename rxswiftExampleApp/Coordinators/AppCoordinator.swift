//
//  AppCoordinator.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 1/25/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let kCartStoryboard = UIStoryboard(name: "Cart", bundle: nil)
let kConstructorStoryboard = UIStoryboard(name: "Constructor", bundle: nil)
let kTankStoryboard = UIStoryboard(name: "Tanks", bundle: nil)

class AppCoordinator {
    private let window: UIWindow
    private var mainFlowCoordinaator: MainFlowCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        start()
    }
    
    func start() {
        self.mainFlowCoordinaator = MainFlowCoordinator(window: self.window)
        self.mainFlowCoordinaator?.start()
    }
    
}
