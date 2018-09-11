//
//  TanksRatingListViewModel.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/20/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TanksRatingListViewModelType {
    var tanks: PublishSubject<[TanksRatingListItemViewModelType]> { get }
    var isLoading: PublishSubject<Bool> { get }
    
    func getTanksRatingList()
    func loadTanksRatingList()
    func presentTankDetails(with model: TanksRatingListItemViewModelType)
    func close()
}

class TanksRatingListViewModel: TanksRatingListViewModelType {
    var tanks: PublishSubject<[TanksRatingListItemViewModelType]> = PublishSubject<[TanksRatingListItemViewModelType]>()
    var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    
    private var navigator: TanksRatingListNavigatorType
    private var model: TankDetailsInfoViewModelType

    private var dataProvider: TanksDataProviderType
    private var disposeBag = DisposeBag()
    
    init(navigator: TanksRatingListNavigatorType, with model: TankDetailsInfoViewModelType) {
        self.model = model
        self.navigator = navigator
        
        self.dataProvider = MoyaTanksDataProvider()
        
        self.dataProvider.filter = TanksFilterBundle()
        self.dataProvider.filter?.tierTypes = [model.property.equipment.tier]
        self.dataProvider.filter?.tankTypes = [model.property.equipment.type]
        
        self.bind()
    }
    
    func getTanksRatingList() {
        if let items = model.viewModel.tankDetailsHeaderViewModel.characteristics.first(where: { $0[0].type == model.property.type } ) {
            self.createViewModel(with: items.map({ $0.equipment }))
        } else {
            self.loadTanksRatingList()
        }
    }
    
    func loadTanksRatingList() {
        self.dataProvider.getTanksPage().asObservable()
            .subscribe(onNext: { [weak self] list in
                self?.createViewModel(with: list)
            }).disposed(by: disposeBag)
    }
    
    private func bind() {
        self.dataProvider.isLoading.asObservable()
            .bind(to: isLoading)
            .disposed(by: disposeBag)
    }
    
    private func createViewModel(with equipment: [EquipmentType]) {
        var viewModels = [TanksRatingListItemViewModelType]()
        
        for tank in equipment {
            let characteristic = PropertyCharacteristic(with: tank, and: model.property.type)
            viewModels.append(TanksRatingListItemViewModel(with: tank, and: characteristic))
        }
        
        // TODO: - Refactor this hack
        viewModels.sort(by: {$0.property.value > $1.property.value })
        let maxValue = viewModels[0].property.value
        
        viewModels.forEach({
            $0.property.upperValue = maxValue
        })
        
        self.tanks.onNext(viewModels)
    }
    
    func presentTankDetails(with model: TanksRatingListItemViewModelType) {
        self.navigator.presentTankDetails(with: model.equipment)
    }
    
    func close() {
        navigator.dismiss()
    }
    
}
