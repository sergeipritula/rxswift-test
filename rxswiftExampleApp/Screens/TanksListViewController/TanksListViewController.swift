//
//  TanksListViewController.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/8/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import AlamofireImage

class TanksListViewController: UIViewController {
 
    @IBOutlet var collectionView: UICollectionView!
    
    var viewModel: TanksListViewModelType!
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func bindViewModel() {
        let refreshControl = UIRefreshControl()
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
        
        collectionView.register(UINib.init(nibName: String(describing: TankCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: TankCollectionViewCell.self))
        
        viewModel.isLoading.asObservable()
            .subscribe(onNext: { loading in
                loading ? AnimationRenderer.startAnimation() : AnimationRenderer.stopAnimation()
            }).disposed(by: disposeBag)
        
        viewModel.errorSubject
            .subscribe(onNext: { error in
                ToastHelper.showToast(message: error.localizedDescription + "\nPull to refresh to get data")
            }).disposed(by: disposeBag)
        
        viewModel.tanks.asObservable()
            .flatMap({Observable.from(optional: $0)})
            .bind(to: collectionView.rx.items(cellIdentifier: String(describing: TankCollectionViewCell.self), cellType: TankCollectionViewCell.self)) { row, data, cell in
                cell.configure(with: data)
            }.disposed(by: disposeBag)
        
        collectionView.rx.willDisplayCell
            .subscribe(onNext: { [weak self] cellInfo in
                if let cell = cellInfo.cell as? TankCollectionViewCell {
                    guard let `self` = self else { return }
                    cell.loadTankImage()
                    
                    if cellInfo.at.row + 1 >= self.viewModel.items.count {
                        self.viewModel.readTankListPage()
                    }
                }
            }).disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(TanksListItemViewModel.self)
            .subscribe(onNext: { [weak self] model in
                self?.viewModel.selectTank(tank: model)
            }).disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent([.valueChanged])
            .subscribe(onNext: { [weak self] _ in
                refreshControl.endRefreshing()
                
                self?.viewModel.reload()
            }).disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    deinit {
        print("TanksListViewController - deinit")
    }
    
}

extension TanksListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width) / 2
        return CGSize(width: cellWidth, height: 70)
    }
    
}
