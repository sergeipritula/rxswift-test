//
//  AlamofireTankListDataProvider.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/26/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class AlamofireTanksDataProvider: TanksDataProviderType {
    internal var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    
    internal var pageNumber: Int
    internal var pageTotal: Int
    
    private var request: TanksRequest!
    internal var filter: TanksFilterBundle?
    
    init() {
        self.pageNumber = 1
        self.pageTotal = 1
    }
    
    func reset() {
        self.pageTotal = 1
        self.pageNumber = 1
    }
    
    func getTanksPage() -> Observable<[EquipmentType]> {
        isLoading.onNext(true)
        
        return Observable.create { (observer) -> Disposable in
            let reference = self.request.execute(pageNumber: self.pageNumber, completion: { [weak self] result in
                guard let `self` = self else { return }
                
                self.isLoading.onNext(false)
                
                switch result {
                case .result(let parsedData):
                    self.pageTotal = parsedData.meta.pageTotal
                    self.pageNumber += 1
                    
                    let equipments = parsedData.data.map({ $0.value })
                    observer.onNext(equipments)
                case .error(let error):
                    observer.onError(error)
                }
            })
            
            return Disposables.create(with: {
                reference?.cancel()
            })
        }
    }
    
}
