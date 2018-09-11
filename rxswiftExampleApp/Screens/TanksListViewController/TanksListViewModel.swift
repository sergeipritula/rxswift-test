//
//  TanksListViewModel.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/9/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol TanksListViewModelType {
    var items: [TanksListItemViewModelType] { get }
    var tanks: PublishSubject<[TanksListItemViewModelType]> { get }
    var errorSubject: PublishSubject<Error> { get }
    var isLoading: PublishSubject<Bool> { get }
    
    func readTankListPage()
    func reload()
    func selectTank(tank: TanksListItemViewModelType)
}

class TanksListViewModel: TanksListViewModelType {
    internal var items: [TanksListItemViewModelType] = []
    var tanks = PublishSubject<[TanksListItemViewModelType]>()
    var errorSubject = PublishSubject<Error>()
    var isLoading = PublishSubject<Bool>()
    
    private var navigator: TanksListNavigatorType
    private let provider: TanksDataProviderType
    private var disposeBag = DisposeBag()
    
    init(navigator: TanksListNavigatorType) {
        self.navigator = navigator
        
        self.provider = MoyaTanksDataProvider()
        self.bind()
        self.readTankListPage()
    }
    
    internal func readTankListPage() {
        self.provider.getTanksPage().asObservable()
            .subscribe(onNext: { [weak self] list in
                self?.createViewModel(with: list)
                }, onError: { [weak self] error in
                    self?.errorSubject.onNext(error)
            }).disposed(by: disposeBag)
    }
    
    func reload() {
        self.items.removeAll()
        self.provider.reset()
        self.readTankListPage()
    }
    
    func bind() {
        self.provider.isLoading.asObservable()
            .bind(to: isLoading)
            .disposed(by: disposeBag)
    }
    
    func selectTank(tank: TanksListItemViewModelType) {
        self.navigator.pushTankInfo(tankModel: tank)
    }
    
    func createViewModel(with equipment: [EquipmentType]) {
        var viewModels = [TanksListItemViewModelType]()
        
        for tank in equipment {
            viewModels.append(TanksListItemViewModel(with: tank))
        }
        
        self.items.append(contentsOf: viewModels)
        self.tanks.onNext(self.items)
    }
}
