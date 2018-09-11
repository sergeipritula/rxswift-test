//
//  TankRatingTableViewCell.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/20/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import UIKit
import RxSwift

class TankRatingTableViewCell: UITableViewCell {
    @IBOutlet weak var isPremiumImageView: UIImageView!
    @IBOutlet weak var tankImageView: UIImageView!
    @IBOutlet weak var nationImageView: UIImageView!
    @IBOutlet weak var tankNameLabel: UILabel!
    @IBOutlet weak var propertyValueLabel: UILabel!
    @IBOutlet weak var propertyComputedCharacteristicLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    private var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: TanksRatingListItemViewModelType) {
        self.tankNameLabel.text = model.name
        self.nationImageView.image = UIImage(named: model.nation)
    
        if model.isPremium {
            self.isPremiumImageView.image = UIImage(named: "coins")
            self.tankNameLabel.textColor = .yellow
        } else {
            self.isPremiumImageView.image = nil
            self.tankNameLabel.textColor = .lightGray
        }
        
        propertyValueLabel.text = String(model.property.value)
        
        var progress: Float = 1
        
        if model.property.upperValue != 0 {
            progress = model.property.value / model.property.upperValue
        }
        
        propertyComputedCharacteristicLabel.text = String(format: "%2.1f", (progress * 10))
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveLinear, animations: {
            self.progressBar.setProgress(progress, animated: true)
        }, completion: nil)
        
        model.tankImage.asObservable()
            .subscribe(onNext: { [weak self] image in
                self?.tankImageView.image = image
            }).disposed(by: disposeBag)
    }
    
}
