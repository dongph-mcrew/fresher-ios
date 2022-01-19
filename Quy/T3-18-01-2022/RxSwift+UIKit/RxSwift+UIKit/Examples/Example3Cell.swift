//
//  CustomCell.swift
//  RxSwift+UIKit
//
//  Created by Mcrew-Tech on 19/01/2022.
//

import UIKit

class Example3Cell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(_ images: Images) {
        titleLabel.text = images.title
        cellImg.image = images.image
    }
}
