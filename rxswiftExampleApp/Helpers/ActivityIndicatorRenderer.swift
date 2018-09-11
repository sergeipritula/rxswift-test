//
//  ActivityIndicatorRenderer.swift
//  wineapp
//
//  Created by BoichenkoVolodymyr on 12/5/17.
//  Copyright © 2017 onix-systems. All rights reserved.
//

import UIKit

class ActivityIndicatorRenderer {
    
    class func show(on view: UIView) {
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(origin: .zero, size: view.frame.size)
        actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        actInd.startAnimating()
        view.addSubview(actInd)
    }
    
    class func hide(on view: UIView) {
        
        for case let actInd as UIActivityIndicatorView in view.subviews{
            actInd.stopAnimating()
            actInd.removeFromSuperview()
        }
    }
}

