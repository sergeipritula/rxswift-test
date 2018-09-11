//
//  TankDetailsInfoTableViewCell.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/12/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import UIKit

class TankDetailsInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var upperValueLabel: UILabel!
    @IBOutlet weak var lowerValueLabel: UILabel!
    @IBOutlet weak var progreesBar: UIProgressView!
    @IBOutlet weak var upgradedValueLabel: UILabel!
    
    private var model: TankDetailsInfoViewModelType!
    
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
    
    func configure(with item: TankDetailsInfoViewModelType) {
        self.descriptionLabel.text = item.property.name
        self.upperValueLabel.text = String(item.property.value)
        
        if item.property.upperValue == 0 {
            self.lowerValueLabel.text = String(format: "%2.1f", (10.0))
        } else {
            let progress = item.property.value / item.property.upperValue
            self.lowerValueLabel.text = String(format: "%2.1f", (progress * 10))
        }
        
        self.model = item
    }
    
    
    func setBaseProgressValue() {
        let progress = model.property.value / model.property.upperValue
       
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveLinear, animations: {
            self.progreesBar.setProgress(progress, animated: true)
        }, completion: nil)
    }
    
    func setUpgradedProgressValue() {
        
    }
    
}
