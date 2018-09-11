//
//  NewTanksListItemViewModel.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/9/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import Alamofire
import UIKit

protocol TanksListItemViewModelType {
    var tankId: Int { get }
    var tankName: String { get }
    var nation: String { get }
    var tankType: String { get }
    var nationImage: UIImage? { get }
    var tankTypeImage: UIImage? { get }
    var tier: String { get }
    var isPremium: Variable<Bool> { get }
    var imageUrl: String? { get }
    var tankImage: Variable<UIImage?> { get }
    var price: Int? { get }
    var priceGold: Int? { get }
    var equipment: EquipmentType { get }
    
    func loadImage()
}

class TanksListItemViewModel: TanksListItemViewModelType {
    var tankId: Int
    var tankName: String
    var nation: String
    var tankType: String
    var nationImage: UIImage?
    var tankTypeImage: UIImage?
    var tier: String
    var imageUrl: String?
    var isPremium: Variable<Bool> = Variable(false)
    var tankImage: Variable<UIImage?> = Variable(nil)
    var price: Int?
    var priceGold: Int?
    
    var equipment: EquipmentType
    
    init(with equipment: EquipmentType) {
        self.tankId = equipment.id
        self.tankName = equipment.name
        self.nation = equipment.nation
        self.tankType = equipment.type
        self.nationImage = UIImage(named: "\(equipment.nation)")
        self.tankTypeImage = UIImage(named: "tank\(equipment.type)")
        self.tier = String(equipment.tier).getRomanianNumber
        self.isPremium.value = equipment.isPremium
        self.imageUrl = equipment.images.bigIcon
        
        if let price = equipment.priceCredit {
            self.price = price
        }
        
        if let priceGold = equipment.priceGold {
            self.priceGold = priceGold
        }
        
        self.equipment = equipment
    }
    
    func loadImage() {
        if tankImage.value == nil {
            if let imageUrl = equipment.images.bigIcon  {
                Alamofire.request(imageUrl).responseData {[weak self] response in
                    if response.error == nil, let data = response.data, let img = UIImage(data: data, scale: 1) {
                        self?.tankImage.value = img
                    } else {
                        self?.tankImage.value = nil
                    }
                }
            }
        }
    }
}
