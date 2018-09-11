
//
//  InfoModalPopupNavigator.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/14/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit

protocol InfoModalPopupNavigatorType {
    func present()
    func dismiss()
}

class InfoModalPopupNavigator: InfoModalPopupNavigatorType {
    internal weak var navigationController: UINavigationController?
    fileprivate weak var controller = kTankStoryboard.instantiateViewController(withIdentifier: "InfoModalPopupViewController") as? InfoModalPopupViewController
    
    init(navigationController: UINavigationController, with model: TankMainInfoViewModelType) {
        self.navigationController = navigationController
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.controller?.viewModel = InfoModalPopupViewModel(navigator: self, with: model)
    }
    
    func present() {
        let navController = UINavigationController(rootViewController: controller!)
        navController.setNavigationBarHidden(true, animated: false)
        navController.modalPresentationStyle = .overCurrentContext
        navController.modalTransitionStyle = .crossDissolve
        self.controller!.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func dismiss() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("InfoModalPopupNavigator - deinit")
    }
    
}
