//
//  TankDetailsMultipleSection.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/12/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxDataSources

enum TankDetailsMultipleSectionModel {
    case ArmamentSection(title: String, items: [TankDetailsMultipleSectionItem])
    case ArmorSection(title: String, items: [TankDetailsMultipleSectionItem])
    case MobilitySection(title: String, items: [TankDetailsMultipleSectionItem])
    case RangeSection(title: String, items: [TankDetailsMultipleSectionItem])
}

enum TankDetailsMultipleSectionItem {
    case TankMainInfoItem(item: TankMainInfoViewModelType)
    case TankDetailsInfoItem(item: TankDetailsInfoViewModelType)
}

extension TankDetailsMultipleSectionModel {
    var title: String {
        switch self {
        case .ArmamentSection(title: let title, items: _):
            return title
        case .ArmorSection(title: let title, items: _):
            return title
        case .MobilitySection(title: let title, items: _):
            return title
        case .RangeSection(title: let title, items: _):
            return title
        }
    }
}

extension TankDetailsMultipleSectionModel: SectionModelType {
    init(original: TankDetailsMultipleSectionModel, items: [Item]) {
        self = original
        
        switch original {
        case .ArmamentSection(title: let title, items: _):
            self = .ArmamentSection(title: title, items: items)
        case .ArmorSection(title: let title, items: _):
            self = .ArmorSection(title: title, items: items)
        case .MobilitySection(title: let title, items: _):
            self = .MobilitySection(title: title, items: items)
        case .RangeSection(title: let title, items: _):
            self = .RangeSection(title: title, items: items)
        }
    }
    
    typealias Item = TankDetailsMultipleSectionItem
    
    var items: [Item] {
        switch  self {
        case .ArmamentSection(title: _, items: let items):
            return items.map {$0}
        case .ArmorSection(title: _, items: let items):
            return items.map {$0}
        case .MobilitySection(title: _, items: let items):
            return items.map {$0}
        case .RangeSection(title: _, items: let items):
            return items.map {$0}
        }
    }
}

extension TankDetailsMultipleSectionModel {
    
    static func createModel(with model: TankDetailsViewModelType) -> [TankDetailsMultipleSectionModel] {
        let armamentSection = TankDetailsArmamentSectionViewModel(with: model)
        let armorSection = TankDetailsArmorSectionViewModel(with: model)
        let mobilitySection = TankDetailsMobilitySectionViewModel(with: model)
        let rangeSection = TankDetailsRangeSectionViewModel(with: model)
        
        var result = [TankDetailsMultipleSectionModel]()
        
        if armamentSection.mainInfoItems.count > 0 {
            var items = armamentSection.mainInfoItems.map({ TankDetailsMultipleSectionItem.TankMainInfoItem(item: $0)})
            items += armamentSection.detailsInfoItems.map({ TankDetailsMultipleSectionItem.TankDetailsInfoItem(item: $0)})
            result.append(TankDetailsMultipleSectionModel.ArmamentSection(title: SectionTitle.Armament.rawValue, items: items))
        }
        
        if armorSection.mainInfoItems.count > 0 {
            var items = armorSection.mainInfoItems.map({ TankDetailsMultipleSectionItem.TankMainInfoItem(item: $0)})
            items += armorSection.detailsInfoItems.map({ TankDetailsMultipleSectionItem.TankDetailsInfoItem(item: $0)})
            result.append(TankDetailsMultipleSectionModel.ArmorSection(title: SectionTitle.Armor.rawValue, items: items))
        }
        
        if mobilitySection.mainInfoItems.count > 0 {
            var items = mobilitySection.mainInfoItems.map({ TankDetailsMultipleSectionItem.TankMainInfoItem(item: $0)})
            items += mobilitySection.detailsInfoItems.map({ TankDetailsMultipleSectionItem.TankDetailsInfoItem(item: $0)})
            result.append(TankDetailsMultipleSectionModel.MobilitySection(title: SectionTitle.Mobility.rawValue, items: items))
        }
        
        if rangeSection.detailsInfoItems.count > 0 {
            var items = rangeSection.mainInfoItems.map({ TankDetailsMultipleSectionItem.TankMainInfoItem(item: $0)})
            items += rangeSection.detailsInfoItems.map({ TankDetailsMultipleSectionItem.TankDetailsInfoItem(item: $0)})
            result.append(TankDetailsMultipleSectionModel.RangeSection(title: SectionTitle.Range.rawValue, items: items))
        }
        
        return result
    }
    
}
