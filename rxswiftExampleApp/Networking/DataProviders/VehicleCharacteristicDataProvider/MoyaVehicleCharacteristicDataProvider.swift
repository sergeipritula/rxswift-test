//
//  MoyaVehicleCharacteristicDataProvider.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/28/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class MoyaVehicleCharacteristicDataProvider: VehicleCharacteristicDataProviderType {
    var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    var configuration: ModulesConfiguration?
    
    private var provider: MoyaProvider<VehiclesAPI>
    private var decoder: JSONDecoder
    
    init() {
        provider = MoyaProvider<VehiclesAPI>()
        decoder = JSONDecoder()
    }
    
    func getProfile() -> Observable<DefaultProfile> {
        isLoading.onNext(true)
        
        return Observable.create { (observer) -> Disposable in
            let cancellable = self.provider.request(VehiclesAPI.vehicle(configuration: self.configuration!), completion: { [weak self] result in
                guard let `self` = self else { return }
                
                self.isLoading.onNext(false)
                
                switch result {
                case .success(let response):
                    if let parsedData = try? self.decoder.decode(DefaultProfileData.self, from: response.data) {
                        let profile = parsedData.data.map( { $0.value })
                        observer.onNext(profile[0])
                    } else {
                       observer.onError(NSError(domain: "Couldn't load selected configuration", code: -1, userInfo: nil))
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            })
            
            return Disposables.create(with: {
                cancellable.cancel()
            })
        }
    }
    
}
