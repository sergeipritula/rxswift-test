//
//  GunInfoView.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/15/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class GunInfoView: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aimTimeLabel: UILabel!
    @IBOutlet weak var caliberLabel: UILabel!
    @IBOutlet weak var dispersionLabel: UILabel!
    @IBOutlet weak var damageLabel: UILabel!
    @IBOutlet weak var penetrationLabel: UILabel!
    @IBOutlet weak var rateOfFireLabel: UILabel!
    @IBOutlet weak var vehiclePriceXPLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var isPremiumImageView: UIImageView!
    
    private var disposeBag = DisposeBag()
    private var model: DefaultProfile!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class open func loadFromNib(profile: DefaultProfile) -> GunInfoView {
        let view = Bundle.main.loadNibNamed(String(describing: GunInfoView.self), owner: self, options: nil)!.first as! GunInfoView
        view.configure(with: profile)
        return view
    }
    
    func configure(with model: DefaultProfile) {
        self.nameLabel.text = model.gun.name
        
        if let aimTime = model.gun.aimTime {
            self.aimTimeLabel.text = String(aimTime)
        }
        
        self.caliberLabel.text = String(model.gun.caliber)
        
        if let dispersion = model.gun.dispersion {
            self.dispersionLabel.text = String(dispersion)
        }
        
        self.damageLabel.text = ""
        self.penetrationLabel.text = ""
        
        model.ammo[0].damage.forEach({self.damageLabel.text! += "\($0)/"})
        model.ammo[0].penetration.forEach({self.penetrationLabel.text! += "\($0)/"})
        
        if let rateOfFire = model.gun.fireRate {
            self.rateOfFireLabel.text = String(rateOfFire)
        }
    }
    
}
