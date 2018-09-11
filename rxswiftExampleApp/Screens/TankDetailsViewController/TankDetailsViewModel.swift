//
//  NewTankDetailsViewModel.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/12/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import RxSwift

public enum SectionTitle: String {
    case Armament = "Armament"
    case Armor = "Armor"
    case Mobility = "Mobility"
    case Range = "Range"
}

protocol TankDetailsViewModelType {
    var tankDetailsSectionsViewModels: PublishSubject<[TankDetailsMultipleSectionModel]> { get }
    var tankDetailsHeaderViewModel: TankDetailsHeaderViewModelType { get }
    var isLoading: PublishSubject<Bool> { get }
    var errorSubject: PublishSubject<Error> { get }
    
    func presentSelectDevice(with model: TankMainInfoViewModelType)
    func presentDeviceInfo(with model: TankMainInfoViewModelType)
    func presentTanksRatingsList(with model: TankDetailsInfoViewModelType)
}

class TankDetailsViewModel: TankDetailsViewModelType {
    var tankDetailsSectionsViewModels: PublishSubject<[TankDetailsMultipleSectionModel]> = PublishSubject<[TankDetailsMultipleSectionModel]>()
    var tankDetailsHeaderViewModel: TankDetailsHeaderViewModelType
    var isLoading = PublishSubject<Bool>()
    var errorSubject = PublishSubject<Error>()
    
    private var tanksListProvider: TanksDataProviderType
    private var tankDetailsDataProvider: TankDetailsDataProviderType
    private var vehicleDataProvider: VehicleCharacteristicDataProviderType
    
    private var navigator: TankDetailsNavigatorType
    private var disposeBag = DisposeBag()
    
    init(navigator: TankDetailsNavigatorType, with model: TanksListItemViewModelType) {
        self.tankDetailsDataProvider = MoyaTankDetailsDataProvider(id: model.tankId)
        self.vehicleDataProvider = MoyaVehicleCharacteristicDataProvider()
        self.tanksListProvider = MoyaTanksDataProvider()
        
        self.tankDetailsHeaderViewModel = TankDetailsHeaderViewModel(with: model)
        self.navigator = navigator
        
        self.bind()
        self.loadTanksRatingList()
    }
    
    private func loadTanksRatingList() {
        tanksListProvider.filter = TanksFilterBundle()
        tanksListProvider.filter?.tierTypes = [self.tankDetailsHeaderViewModel.equipment.tier]
        tanksListProvider.filter?.tankTypes = [self.tankDetailsHeaderViewModel.equipment.type]
        
        tanksListProvider.getTanksPage().asObservable()
            .subscribe(onNext: { [weak self] list in
                guard let `self` = self else { return }
                
                var characteristic = [[PropertyCharacteristic]]()
                
                for type in PropertiesType.allValues {
                    var chars = [PropertyCharacteristic]()
                    list.forEach( { equipment in
                        chars.append(PropertyCharacteristic(with: equipment, and: type))
                    })
                    
                    if let maxValue = chars.max(by: { $0.value < $1.value })?.value {
                        for i in 0..<chars.count {
                            chars[i].upperValue = maxValue
                        }
                    }
                    characteristic.append(chars)
                }
                
                self.tankDetailsHeaderViewModel.initCharacteristics(with: characteristic)
                self.loadTankDetails()
                }, onError: { [weak self] error in
                    self?.navigator.dissmis()
            }).disposed(by: disposeBag)
    }
    
    private func loadTankDetails() {
        self.tankDetailsDataProvider.getTankDetails()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] equipment in
                guard let `self` = self else { return }
                
                self.tankDetailsHeaderViewModel.updateEquipment(with: equipment)
                }, onError: { [weak self] error in
                    self?.errorSubject.onNext(error)
            }).disposed(by: disposeBag)
    }
    
    private func loadTankVehiclesCharacteristics() {
        self.vehicleDataProvider.getProfile().asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] profile in
                guard let `self` = self else { return }
                
                self.tankDetailsHeaderViewModel.changeProfile(with: profile)
            }, onError: { [weak self] error in
                self?.errorSubject.onNext(error)
            }).disposed(by: disposeBag)
    }
    
    private func bind() {
        self.tankDetailsHeaderViewModel.configurationVersionSubject.asObservable()
            .subscribe(onNext: { [weak self] version in
                guard let `self` = self else { return }
                
                self.vehicleDataProvider.configuration = self.tankDetailsHeaderViewModel.selectedConfiguration
                self.loadTankVehiclesCharacteristics()
            }).disposed(by: disposeBag)
        
        self.tankDetailsHeaderViewModel.equipmentSubject.asObservable()
            .flatMap { Observable.from(optional: $0) }
            .map { _ in return TankDetailsMultipleSectionModel.createModel(with: self) }
            .bind(to: self.tankDetailsSectionsViewModels)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(self.vehicleDataProvider.isLoading, self.tankDetailsDataProvider.isLoading, self.tanksListProvider.isLoading).asObservable()
            .map { $0 || $1 || $2 }
            .bind(to: isLoading)
            .disposed(by: disposeBag)
    }
    
    func presentSelectDevice(with model: TankMainInfoViewModelType) {
        navigator.presentAvailableDevices(with: model)
    }
    
    func presentDeviceInfo(with model: TankMainInfoViewModelType) {
        navigator.presentDeviceInfo(with: model)
    }
    
    func presentTanksRatingsList(with model: TankDetailsInfoViewModelType) {
        navigator.presentTanksRatingList(with: model)
    }
    
}

