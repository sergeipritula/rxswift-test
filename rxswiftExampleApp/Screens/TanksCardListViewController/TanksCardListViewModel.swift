//
//  TanksCardListViewModel.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 3/6/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift

protocol TanksCardListViewModelType {
    var items: [TanksCardListItemViewModelType] { get }
    var tanks: PublishSubject<[TanksCardListItemViewModelType]> { get }
    var isLoading: PublishSubject<Bool> { get }
    
    func readTankListPage()
    func selectTank(tank: TanksCardListItemViewModelType)
}

class TanksCardListViewModel: TanksCardListViewModelType {
    internal var items: [TanksCardListItemViewModelType] = []
    var tanks: PublishSubject<[TanksCardListItemViewModelType]> = PublishSubject<[TanksCardListItemViewModelType]>()
    var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    
    private var navigator: TanksCardListNavigatorType
    private let provider: TanksDataProviderType
    private var disposeBag = DisposeBag()
    
    init(navigator: TanksCardListNavigatorType) {
        self.navigator = navigator
        
        self.provider = MoyaTanksDataProvider()
        self.bind()
        self.readTankListPage()
    }
    
    internal func readTankListPage() {
        self.provider.getTanksPage().asObservable()
            .subscribe(onNext: { [weak self] list in
                self?.createViewModel(with: list)
            }).disposed(by: disposeBag)
    }
    
    func bind() {
        self.provider.isLoading.asObservable()
            .bind(to: isLoading)
            .disposed(by: disposeBag)
    }
    
    func selectTank(tank: TanksCardListItemViewModelType) {
        self.navigator.pushTankInfo(tankModel: tank)
    }
    
    func createViewModel(with equipment: [EquipmentType]) {
        var viewModels = [TanksCardListItemViewModelType]()
        
        for tank in equipment {
            viewModels.append(TanksCardListItemViewModel(with: tank))
        }
        
        self.items.append(contentsOf: viewModels)
        self.tanks.onNext(self.items)
    }
    
}
