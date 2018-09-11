//
//  TankCardView.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 3/6/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Koloda

class TankCardView: KolodaView {
    @IBOutlet weak var tankNameLabel: UILabel!
    @IBOutlet weak var tankImageView: UIImageView!
    @IBOutlet weak var isPremiumImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nationImageView: UIImageView!
    @IBOutlet weak var nationLabel: UILabel!
    @IBOutlet weak var tierLabel: UILabel!
    @IBOutlet weak var tankTypeLabel: UILabel!
    @IBOutlet weak var tankTypeImageView: UIImageView!
    
    private var model: TanksCardListItemViewModelType!
    private var disposeBag = DisposeBag()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    class open func loadNib() -> TankCardView {
        let view = Bundle.main.loadNibNamed(String(describing: TankCardView.self), owner: self, options: nil)!.first as! TankCardView
        
        let shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 2.0)
        
        view.layer.cornerRadius = 2.0
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0);
        view.layer.shadowOpacity = 1.0
        view.layer.shadowPath = shadowPath.cgPath
        
        return view
    }
    
    override func frameForCard(at index: Int) -> CGRect {
        if index == 0 {
            let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            return frame
        }
        
        return CGRect.zero
    }
    
    @IBAction func likeButtonTouchUpInside(_ sender: UIButton) {
        print("like clicked")
    }
    
    @IBAction func dislikeButtonTouchUpInside(_ sender: UIButton) {
        print("dislike clicked")
    }
    
    func configure(with model: TanksCardListItemViewModelType) {
        self.tankNameLabel.text = model.name
        self.nationLabel.text = model.nation
        self.priceLabel.text = String(model.price)
        self.tierLabel.text = model.tier
        self.tankTypeLabel.text = model.type
        
        self.isPremiumImageView.image = model.isPremiumImage
        self.nationImageView.image = model.nationImage
        self.tankTypeImageView.image = model.typeImage
        
        model.tankImage.asObservable()
            .subscribe(onNext: { [weak self] image in
                self?.tankImageView.image = image
            }).disposed(by: disposeBag)
        
        model.loadImage()
        self.model = model
    }
}
