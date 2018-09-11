//
//  TanksRatingListItemViewModel.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/20/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Alamofire

protocol TanksRatingListItemViewModelType {
    var name: String { get }
    var nation: String { get }
    var type: String { get }
    var isPremium: Bool { get }
    var property: PropertyCharacteristic { get }
    var equipment: EquipmentType { get }
    var tankImage: Variable<UIImage?> { get }
}

class TanksRatingListItemViewModel: TanksRatingListItemViewModelType {
    var name: String
    var nation: String
    var type: String
    var isPremium: Bool
    var property: PropertyCharacteristic
    var equipment: EquipmentType
    var tankImage: Variable<UIImage?> = Variable(nil)
    
    init(with equipment: EquipmentType, and property: PropertyCharacteristic) {
        self.equipment = equipment
        
        self.name = equipment.name
        self.nation = equipment.nation
        self.type = equipment.type
        self.isPremium = equipment.isPremium
        self.property = property
        
        if let url = equipment.images.bigIcon {
            Alamofire.request(url).responseData { [weak self] response in
                if response.error == nil, let data = response.data, let img = UIImage(data: data, scale: 1) {
                    self?.tankImage.value = img
                } else {
                    self?.tankImage.value = nil
                }
            }
        }
    }
    
}
