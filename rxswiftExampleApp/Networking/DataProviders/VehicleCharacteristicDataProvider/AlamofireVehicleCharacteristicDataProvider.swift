//
//  AlamofireVehicleCharacteristicDataProvideer.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/28/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift

class AlamofireVehicleCharacteristicDataProvider: VehicleCharacteristicDataProviderType {
    var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    internal var configuration: ModulesConfiguration?
    
    private var request: VehicleCharacteristicsRequest
    
    init() {
        self.request = VehicleCharacteristicsRequest()
    }
    
    func getProfile() -> Observable<DefaultProfile> {
        request.configuration = configuration
        isLoading.onNext(true)
        
        return Observable<DefaultProfile>.create { (observer) -> Disposable in
            let refference = self.request.execute(completion: {[weak self] result in
                guard let `self` = self else { return }
                
                self.isLoading.onNext(false)
                
                switch result {
                case .result(let profile):
                    observer.onNext(profile)
                case .error(let error):
                    observer.onError(error)
                }
            })
            
            return Disposables.create(with: {
                refference?.cancel()
            })
        }
    }
    
}
