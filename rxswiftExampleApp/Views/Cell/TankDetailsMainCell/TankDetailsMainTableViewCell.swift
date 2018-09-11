//
//  TankDetailsMainTableViewCell.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/12/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import UIKit

class TankDetailsMainTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var equipmentImageView: UIImageView!
    
    private var model: TankMainInfoViewModelType!
    
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
    
    func configure(with model: TankMainInfoViewModelType) {
        self.descriptionLabel.text = "\(model.device.type.rawValue) : \(model.device.name)"
        self.model = model
    }
    
    @IBAction func infoButtonClicked(_ sender: UIButton){
        self.model.pushDeviceInfo()
    }
}
