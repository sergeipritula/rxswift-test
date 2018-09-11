//  ActivityIndicatorRenderer.swift
//
//  Created by Serhiy on 2/6/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//


import MBProgressHUD
import SnapKit

class AnimationRenderer {
    static var imageView: UIImageView?
    
    class func startAnimation() {
        guard let view = UIApplication.shared.keyWindow else { return }
        
        if self.imageView == nil {
            imageView = UIImageView(image: UIImage(named: "reload"))
            imageView?.contentMode = .scaleAspectFit
            
            view.addSubview(self.imageView!)
            
            self.imageView?.snp.makeConstraints({ (make) -> Void in
                make.center.equalTo(view)
            })
            
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Double.pi
            rotationAnimation.duration = 2.0
            rotationAnimation.repeatCount = Float.infinity
            
            self.imageView?.layer.add(rotationAnimation, forKey: nil)
            view.isUserInteractionEnabled = false
        }
    }
    
    class func stopAnimation() {
        guard let view = UIApplication.shared.keyWindow else { return }
        
        if let image = imageView {
            image.removeFromSuperview()
        }
        
        view.isUserInteractionEnabled = true
        imageView = nil
    }
}
