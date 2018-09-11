//
//  MoyaTankDetailsDataProvider.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/27/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class MoyaTankDetailsDataProvider: TankDetailsDataProviderType {
    internal var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    
    private let decoder: JSONDecoder
    private var provider: MoyaProvider<TanksAPI>
    internal var id: Int
    
    init(id: Int) {
        decoder = JSONDecoder()
        provider = MoyaProvider<TanksAPI>()
        self.id = id
    }
    
    func getTankDetails() -> Observable<EquipmentType> {
        isLoading.onNext(true)
        
        return Observable.create { (observer) -> Disposable in
            let cancellable = self.provider.request(TanksAPI.tank(id: String(self.id)), completion: { [weak self] result in
                guard let `self` = self else { return }
                
                self.isLoading.onNext(false)
                
                switch result {
                case .success(let response):
                    if let parsedData = try? self.decoder.decode(EquipmentList.self, from: response.data) {
                        let vehicles = parsedData.data.map({ $0.value })
                        observer.onNext(vehicles[0])
                    } else {
                        observer.onError(NSError(domain: "Couldn't load tank details", code: -1, userInfo: nil))
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
