//
//  TankDetailsHeaderView.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 3/2/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class TankDetailsHeaderView: UIView {
    @IBOutlet var tankImageView: UIImageView!
    @IBOutlet var nationImageView: UIImageView!
    @IBOutlet var typeImageView: UIImageView!
    @IBOutlet var isPremiumImageView: UIImageView!
    @IBOutlet var nationLabel: UILabel!
    @IBOutlet var tankTypeLabel: UILabel!
    @IBOutlet var tierLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var configurationSettingLabel: UILabel!
    @IBOutlet var changeButton: UIButton!
    
    private var model: TankDetailsHeaderViewModelType!
    private var disposeBag = DisposeBag()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    class open func loadNib() -> TankDetailsHeaderView {
        let view = Bundle.main.loadNibNamed(String(describing: TankDetailsHeaderView.self), owner: self, options: nil)!.first as! TankDetailsHeaderView
        return view
    }
    
    func configure(with model: TankDetailsHeaderViewModelType) {
        self.nationLabel.text = model.equipment.nation.TransformedCountryName
        self.tankTypeLabel.text = model.equipment.type.TransformedTankType
        self.tierLabel.text = String(model.equipment.tier).getRomanianNumber
        
        if model.equipment.isPremium {
            self.priceLabel.text = String(model.equipment.priceGold ?? 0)
            self.isPremiumImageView.image = UIImage(named: "coins")
        } else {
            self.priceLabel.text = String(model.equipment.priceCredit ?? 0)
            self.isPremiumImageView.image = UIImage(named: "silver_coins")
        }
        
        let formattedString = NSMutableAttributedString()
        if model.selectedConfiguration.supportAdvancedConfiguration {
            formattedString.normal("Ratings of \(model.equipment.type.TransformedTankType.lowercased()) of tier \(String(model.equipment.tier).getRomanianNumber) with").bold(" basic configuration")
            self.configurationSettingLabel.attributedText = formattedString
        } else {
            formattedString.normal("Ratings of \(model.equipment.type.TransformedTankType.lowercased()) of tier \(String(model.equipment.tier).getRomanianNumber) with").bold(" advanced configuration")
            self.configurationSettingLabel.attributedText = formattedString
            self.changeButton.isHidden = true
        }
        
        self.nationImageView.image = UIImage(named: model.equipment.nation)
        self.typeImageView.image = UIImage(named: "tank\(model.equipment.type)")
        self.tankImageView.image = model.tankImage
      
        self.model = model
        self.bind()
    }
    
    private func bind() {
        model.configurationVersionSubject.subscribe(onNext: { version in
            let formattedString = NSMutableAttributedString()

            if version == .Base  {
                formattedString.normal("Ratings of \(self.model.equipment.type.TransformedTankType.lowercased()) of tier \(String(self.model.equipment.tier).getRomanianNumber) with")
                    .bold(" basic configuration")
                self.configurationSettingLabel.attributedText = formattedString
            } else {
                formattedString.normal("Ratings of \(self.model.equipment.type.TransformedTankType.lowercased()) of tier \(String(self.model.equipment.tier).getRomanianNumber) with")
                    .bold(" advanced configuration")
                self.configurationSettingLabel.attributedText = formattedString
            }
        }).disposed(by: disposeBag)
    }
    
    @IBAction func changeButtonTouchUpInside(_ sender: UIButton) {
        if self.model.configurationVersion == .Base {
            self.model.changeConfiguration(with: .Advanced)
        } else {
            self.model.changeConfiguration(with: .Base)
        }
    }
    
}
