//
//  EngineInfoView.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/15/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import UIKit
import RxSwift

class EngineInfoView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var fireChanceLabel: UILabel!
    @IBOutlet weak var vehiclePriceXPLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    private var model: DefaultProfile!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class open func loadFromNib(profile: DefaultProfile) -> EngineInfoView {
        let view = Bundle.main.loadNibNamed(String(describing: EngineInfoView.self), owner: self, options: nil)!.first as! EngineInfoView
        view.configure(with: profile)
        return view
    }
    
    func configure(with model: DefaultProfile) {
        self.nameLabel.text = model.engine.name
        self.powerLabel.text = String(model.engine.power)
        
        if let fireChance = model.engine.fire_chance {
            self.fireChanceLabel.text = String(fireChance)
        }
        
    }
}
