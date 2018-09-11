//
//  TanksCardCollectionViewCell.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 3/6/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import UIKit
import RxSwift

class TanksCardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tankNameLabel: UILabel!
    @IBOutlet weak var tankImageView: UIImageView!
    
    var model: TanksCardListItemViewModelType!
    private var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with model: TanksCardListItemViewModelType) {
        self.tankNameLabel.text = model.name
        
        model.tankImage.subscribe(onNext: { [weak self] image in
            self?.tankImageView.image = image
        }).disposed(by: disposeBag)
        
        model.loadImage()
        self.model = model
    }
    
    @IBAction func dislikeButtonTouchUpInside(_ sender: UIButton) {
        
    }
    
    
    @IBAction func likeButtonTouchUpInside(_ sender: UIButton) {
        
    }
    
}
