//
//  RadioInfoView.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/15/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import UIKit
import RxSwift

class RadioInfoView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
     */
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var signalRangeLabel: UILabel!
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
    
    class open func loadFromNib(profile: DefaultProfile) -> RadioInfoView {
        let view = Bundle.main.loadNibNamed(String(describing: RadioInfoView.self), owner: self, options: nil)!.first as! RadioInfoView
        view.configure(with: profile)
        return view
    }
    
    func configure(with model: DefaultProfile) {
        self.signalRangeLabel.text = String(model.radio.signalRange)
        self.nameLabel.text = model.radio.name
    }
}
