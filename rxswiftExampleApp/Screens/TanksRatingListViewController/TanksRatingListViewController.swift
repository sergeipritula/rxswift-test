//
//  TanksRatingListViewController.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/20/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TanksRatingListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: TanksRatingListViewModelType!
    private var disposeBag = DisposeBag()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getTanksRatingList()
    }
    
    private func bindViewModel() {
        tableView.register(UINib.init(nibName: String(describing: TankRatingTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TankRatingTableViewCell.self))
        tableView.separatorColor = .clear
        
        viewModel.isLoading.asObservable()
            .subscribe(onNext: { loading in
                loading ? AnimationRenderer.startAnimation() : AnimationRenderer.stopAnimation()
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
        
        viewModel.tanks.asObservable()
            .flatMap({Observable.from(optional: $0)})
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: TankRatingTableViewCell.self), cellType: TankRatingTableViewCell.self)) { row, data, cell in
                cell.configure(with: data)
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(TanksRatingListItemViewModelType.self)
            .subscribe(onNext: { [weak self] model in
                self?.viewModel.presentTankDetails(with: model)
            }).disposed(by: disposeBag)
    }
    
    deinit {
        print("TanksRatingListViewController - deinit")
    }

}
