//
//  NewTankDetailsViewController.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/9/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TankDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tankDetailsHeaderView: TankDetailsHeaderView!
    
    var viewModel: TankDetailsViewModelType!
    private var disposeBag = DisposeBag()
    
    private let dataSource = RxTableViewSectionedReloadDataSource<TankDetailsMultipleSectionModel>(
        configureCell: { (dataSource, table, idxPath, _) in
            switch dataSource[idxPath] {
                
            case let .TankMainInfoItem(item):
                let cell = table.dequeueReusableCell(withIdentifier: String(describing: TankDetailsMainTableViewCell.self), for: idxPath) as! TankDetailsMainTableViewCell
                cell.configure(with: item)
                return cell
                
            case let .TankDetailsInfoItem(item):
                let cell = table.dequeueReusableCell(withIdentifier: String(describing: TankDetailsInfoTableViewCell.self), for: idxPath) as! TankDetailsInfoTableViewCell
                cell.configure(with: item)
                return cell
            }
    },
        titleForHeaderInSection: { dataSource, index in
            let section = dataSource[index]
            return section.title
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let headerView = TankDetailsHeaderView.loadNib()
        headerView.configure(with: viewModel.tankDetailsHeaderViewModel)
        tankDetailsHeaderView.addSubview(headerView)
        
        self.bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func bindViewModel() {
        tableView.register(UINib(nibName: String(describing: TankDetailsMainTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TankDetailsMainTableViewCell.self))
        tableView.register(UINib(nibName: String(describing: TankDetailsInfoTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TankDetailsInfoTableViewCell.self))
        
        viewModel.isLoading.asObservable()
            .subscribe(onNext: { loading in
                loading ? AnimationRenderer.startAnimation() : AnimationRenderer.stopAnimation()
            }).disposed(by: disposeBag)
        
        viewModel.errorSubject
            .subscribe(onNext: { error in
                ToastHelper.showToast(message: error.localizedDescription)
            }).disposed(by: disposeBag)
        
        viewModel.tankDetailsSectionsViewModels.asObservable()
            .bind(to: tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
        
        tableView.rx.willDisplayCell
            .subscribe(onNext: { cellInfo in
                if let cell = cellInfo.cell as? TankDetailsInfoTableViewCell {
                    cell.setBaseProgressValue()
                }
            }).disposed(by: disposeBag)
        
        tableView.rx
            .itemSelected
            .map { indexPath in return indexPath }
            .subscribe(onNext: { [weak self] in
                self?.tableView.deselectRow(at: $0, animated: false)
            }).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(TankDetailsMultipleSectionItem.self)
            .subscribe(onNext: { [weak self] model in
                guard let `self` = self else { return }
                
                switch model {
                case .TankDetailsInfoItem(let item):
                    self.viewModel.presentTanksRatingsList(with: item)
                case .TankMainInfoItem(let item):
                    self.viewModel.presentSelectDevice(with: item)
                }
            }).disposed(by: disposeBag)
    }
    
    deinit {
        print("TankDetailsViewController - deinit")
    }
    
}

