//
//  DeviceSelectViewController.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/15/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class DeviceSelectViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var viewModel: DeviceSelectViewModelType!
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    func bindViewModel() {
        tableView.register(UINib.init(nibName: String(describing: DeviceSelectTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DeviceSelectTableViewCell.self))
        
        tableView.separatorColor = .clear
        
        viewModel.itemsObserver.asObservable()
            .flatMap({Observable.from(optional: $0)})
            .subscribe(onNext: { [weak self] _ in
                self?.heightConstraint.constant += CGFloat(40)
                self?.tableView.setNeedsLayout()
            }).disposed(by: disposeBag)
        
        viewModel.itemsObserver.asObservable()
            .flatMap({Observable.from(optional: $0)})
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: DeviceSelectTableViewCell.self), cellType: DeviceSelectTableViewCell.self)) { row, data, cell in
                cell.configure(with: data)
            }.disposed(by: disposeBag)
    
        tableView.rx.modelSelected(DeviceSelectItemViewModelType.self)
            .subscribe(onNext: { [weak self] item in
                self?.viewModel.select(with: item)
            }).disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        self.viewModel.dismiss()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.tableView
    }
    
    deinit {
        print("DeviceSelectViewController - deinit")
    }
    
}

extension DeviceSelectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        let text = NSMutableAttributedString(string: viewModel.device.type.rawValue, attributes: [ NSAttributedStringKey.paragraphStyle: style ])
        
        label.backgroundColor = UIColor(14, 40, 20)
        label.attributedText = text
        label.textColor = UIColor.lightGray
        
        return label
    }
        
}
