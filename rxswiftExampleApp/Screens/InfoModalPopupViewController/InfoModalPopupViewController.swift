//
//  InfoModalPopupViewController.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/14/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

class InfoModalPopupViewController: UIViewController, UIGestureRecognizerDelegate {
    var viewModel: InfoModalPopupViewModelType!
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.profile.asObserver()
            .subscribe(onNext: { [weak self] profile in
                if let profile = profile {
                    self?.configure(with: profile)
                }
            }).disposed(by: disposeBag)
    }
    
    private func configure(with profile: DefaultProfile) {
        let infoView: UIView?
        
        switch viewModel.device.type {
        case .Gun:
            infoView = GunInfoView.loadFromNib(profile: profile)
        case .Turret:
            infoView = TurretInfoView.loadFromNib(profile: profile)
        case .Engine:
            infoView = EngineInfoView.loadFromNib(profile: profile)
        case .Suspension:
            infoView = SuspensionInfoView.loadFromNib(profile: profile)
        case .Radio:
            infoView = RadioInfoView.loadFromNib(profile: profile)
        }
        
        if let infoView = infoView {
            makeConstraints(infoView: infoView)
        }
    }
    
    private func makeConstraints(infoView: UIView) {
        self.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        infoView.layer.cornerRadius = 20
        self.view.addSubview(infoView)
        
        infoView.snp.makeConstraints({ (make) -> Void in
            make.center.equalTo(self.view.snp.center)
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        })
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.view
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        self.viewModel.dismiss()
    }
    
    deinit {
        print("InfoModalPopupViewController - deinit")
    }
    
}
