//
//  TanksCardListItemViewModel.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 3/6/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

protocol TanksCardListItemViewModelType {
    var name: String { get }
    var nation: String { get }
    var tier: String { get }
    var type: String { get }
    var nationImage: UIImage? { get }
    var typeImage: UIImage? { get }
    var isPremiumImage: UIImage? { get }
    var price: Int { get }
    var tankImage: PublishSubject<UIImage?> { get }
    var equipment: EquipmentType { get }
    
    func loadImage()
}

class TanksCardListItemViewModel: TanksCardListItemViewModelType {
    var name: String
    var nation: String
    var tier: String
    var type: String
    var nationImage: UIImage?
    var typeImage: UIImage?
    var isPremiumImage: UIImage?
    var price: Int
    var tankImage: PublishSubject<UIImage?> = PublishSubject<UIImage?>()
    
    var equipment: EquipmentType
    
    init(with equipment: EquipmentType) {
        self.name = equipment.name
        self.nation = equipment.nation.TransformedCountryName
        self.tier = String(equipment.tier).getRomanianNumber
        self.type = equipment.type.TransformedTankType
        
        self.nationImage = UIImage(named: equipment.nation)
        self.typeImage = UIImage(named: "tank\(equipment.type)")
        
        if equipment.isPremium {
            self.isPremiumImage = UIImage(named: "coins")
        } else {
            self.isPremiumImage = UIImage(named: "silver_coins")
        }
        
        if let price = equipment.priceCredit {
            self.price = price
        } else if let price = equipment.priceGold {
            self.price = price
        } else {
            price = 0
        }
        
        self.equipment = equipment
    }
    
    func loadImage() {
        AnimationRenderer.startAnimation()
        if let imageUrl = equipment.images.bigIcon  {
            Alamofire.request(imageUrl).responseData { [weak self] response in
                AnimationRenderer.stopAnimation()
                if response.error == nil, let data = response.data, let img = UIImage(data: data, scale: 1) {
                    self?.tankImage.onNext(img)
                } else {
                    self?.tankImage.onNext(nil)
                }
            }
        }
    }
    
}
