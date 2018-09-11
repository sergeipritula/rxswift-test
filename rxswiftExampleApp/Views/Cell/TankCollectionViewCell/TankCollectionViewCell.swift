//
//  TankCollectionViewCell.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/9/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AlamofireImage

class TankCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tankImageView: UIImageView!
    @IBOutlet weak var tankNameLabel: UILabel!
    @IBOutlet weak var nationImageView: UIImageView!
    @IBOutlet weak var tankTypeImageView: UIImageView!
    @IBOutlet weak var tierLabel: UILabel!
    @IBOutlet weak var isPremiumImageView: UIImageView!
    @IBOutlet weak var triangleView: TriangleView!
    
    private var disposeBag = DisposeBag()
    fileprivate var model: TanksListItemViewModelType!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        tankImageView.layer.shadowColor = UIColor.black.cgColor
        tankImageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        tankImageView.layer.shadowOpacity = 1
        tankImageView.layer.shadowRadius = 1.0
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

extension TankCollectionViewCell {
    func configure(with model: TanksListItemViewModelType) {
        self.tankNameLabel.text = model.tankName
        
        if let image = model.nationImage {
            self.nationImageView.image = image
        }
        
        if model.isPremium.value {
            self.tankNameLabel.textColor = UIColor.yellow
            self.isPremiumImageView.image = UIImage(named: "coins")
            self.triangleView.isHidden = false
        } else {
            self.tankNameLabel.textColor = UIColor.white
            self.isPremiumImageView.image = nil
            self.triangleView.isHidden =  true
        }
        
        if let image = model.tankTypeImage {
            self.tankTypeImageView.image = image
        }
        
        self.tierLabel.text = model.tier
        
        self.model = model
    }
    
    func loadTankImage() {
        model.loadImage()
        
        model.tankImage.asObservable()
            .subscribe(onNext: { image in
                self.tankImageView.image = image
            }).disposed(by: disposeBag)
    }
}
