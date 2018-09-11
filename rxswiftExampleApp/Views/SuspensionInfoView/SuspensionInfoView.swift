//
//  SuspensionInfoView.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/15/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import UIKit
import RxSwift

class SuspensionInfoView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loadLimitLabel: UILabel!
    @IBOutlet weak var traverseSpeedLabel: UILabel!
    @IBOutlet weak var vehiclePriceXPLabel: UILabel!
    @IBOutlet weak var isPremiumImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    private var model: DefaultProfile!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class open func loadFromNib(profile: DefaultProfile) -> SuspensionInfoView {
        let view = Bundle.main.loadNibNamed(String(describing: SuspensionInfoView.self), owner: self, options: nil)!.first as! SuspensionInfoView
        view.configure(with: profile)
        return view
    }
    
    func configure(with model: DefaultProfile) {
        self.nameLabel.text = model.suspension.name
        
        if let limit = model.suspension.load_limit {
            self.loadLimitLabel.text = String(limit)
        }
        
        if let traverseSpeed = model.suspension.traverse_speed {
            self.traverseSpeedLabel.text = String(traverseSpeed)
        }
        
    }
}
