//
//  MoyaTankListDataProvider.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/26/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import RxSwift

class MoyaTanksDataProvider: TanksDataProviderType {
    internal var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    
    internal var pageNumber: Int
    internal var pageTotal: Int
    
    internal var filter: TanksFilterBundle?
    
    private let decoder: JSONDecoder
    private var provider: MoyaProvider<TanksAPI>
    
    init() {
        provider = MoyaProvider<TanksAPI>()
        decoder = JSONDecoder()
        
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
            let cancellable = self.provider.request(.tanks(pageNumber: self.pageNumber, filter: self.filter)) { [weak self] result in
                guard let `self` = self else { return }
                
                self.isLoading.onNext(false)
                
                switch result {
                case .success(let response):
                    if let parsedData = try? self.decoder.decode(EquipmentList.self, from: response.data) {
                        let vehicles = parsedData.data.map({ $0.value })
                        observer.onNext(vehicles)
                        
                        self.pageTotal = parsedData.meta.pageTotal
                        self.pageNumber += 1
                    } else {
                        observer.onError(NSError(domain: "Couldn't load tank list", code: -1, userInfo: nil))
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create(with: {
                cancellable.cancel()
            })
        }
    }
    
}
