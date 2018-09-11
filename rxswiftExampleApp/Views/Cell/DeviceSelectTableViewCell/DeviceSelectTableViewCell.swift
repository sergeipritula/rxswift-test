//
//  DeviceSelectTableViewCell.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/16/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import UIKit

class DeviceSelectTableViewCell: UITableViewCell {
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var isCheckedImageView: UIImageView!
    
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
    
    func configure(with model: DeviceSelectItemViewModelType) {
        self.deviceNameLabel.text = model.description
        
        if model.isChecked {
            self.isCheckedImageView.image = UIImage(named: "tick")
        } else {
            self.isCheckedImageView.image = nil
        }
    }
}
