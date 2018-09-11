//
//  VehicleCharacteristicDataProviderType.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/28/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift

protocol VehicleCharacteristicDataProviderType {
    var isLoading: PublishSubject<Bool> { get }
    var configuration: ModulesConfiguration? { get set }
    
    func getProfile() -> Observable<DefaultProfile>
}
