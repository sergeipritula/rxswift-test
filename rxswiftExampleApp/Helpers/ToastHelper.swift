//
//  ToastHelper.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/6/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit

class ToastHelper: NSObject {
    
    class func showToast(message : String) {
        
        guard let root = UIApplication.shared.keyWindow?.rootViewController  else {
            return
        }
        
        let toastLabel = UILabel()
        toastLabel.numberOfLines = 0
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        let fixedWidth = UIScreen.main.bounds.width - 20.0
        
        // Calculate the biggest size that fixes in the given CGSize
        let newSize = toastLabel.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        toastLabel.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        toastLabel.frame.size.height += 20
        toastLabel.center = root.view.center
        toastLabel.frame.origin.y = root.view.frame.size.height-120
        root.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 5.0, delay: 0.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
