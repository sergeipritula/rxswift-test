//
//  AlamofireTankDetailsRequest.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/27/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class AlamofireTankDetailsDataProvider: TankDetailsDataProviderType {
    internal var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    internal var id: Int
    
    private var request: TankDetailRequest
    
    init(id: Int) {
        self.id = id
        self.request = TankDetailRequest(id: self.id)
    }
    
    func getTankDetails() -> Observable<EquipmentType> {
        isLoading.onNext(true)
        
        return Observable.create { (observer) -> Disposable in
            let refference = self.request.execute(completion: {[weak self] result in
                guard let `self` = self else { return }
                
                self.isLoading.onNext(false)
                
                switch result {
                case .result(let equipment):
                    observer.onNext(equipment)
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
