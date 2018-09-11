//
//  TanksCardListViewController.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 3/6/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Koloda

class TanksCardListViewController: UIViewController {
    
    var viewModel: TanksCardListViewModelType!
    @IBOutlet weak var tankCardView: TankCardView!
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tankCardView.dataSource = self
        tankCardView.delegate = self
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        self.bind()
    }
    
    private func bind() {
        viewModel.tanks.asObservable()
            .subscribe(onNext: { [weak self] result in
                self?.tankCardView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    private func setup() {
        
    }
    
}

extension TanksCardListViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        self.viewModel.selectTank(tank: viewModel.items[index])
    }
    
}

// MARK: KolodaViewDataSource
extension TanksCardListViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return viewModel.items.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let view = TankCardView.loadNib()
        view.configure(with: viewModel.items[index])
        return view
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return nil
    }
}

