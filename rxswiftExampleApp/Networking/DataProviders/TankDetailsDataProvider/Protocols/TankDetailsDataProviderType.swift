//
//  TankDetailsDataProviderType.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/27/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift

protocol TankDetailsDataProviderType {
    var isLoading: PublishSubject<Bool> { get }
    var id: Int { get }
    
    func getTankDetails() -> Observable<EquipmentType>
}
