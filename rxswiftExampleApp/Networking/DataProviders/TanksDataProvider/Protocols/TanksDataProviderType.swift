//
//  TanksListDataProviderType.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/26/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift

protocol TanksDataProviderType {
    var isLoading: PublishSubject<Bool> { get }
    
    var filter: TanksFilterBundle? { get set}
    
    var pageNumber: Int { get }
    var pageTotal: Int { get }
    
    func reset()
    func getTanksPage() -> Observable<[EquipmentType]>
}
