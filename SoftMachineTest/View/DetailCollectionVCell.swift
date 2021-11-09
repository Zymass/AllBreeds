//
//  DetailCollectionVCell.swift
//  SoftMachineTest
//
//  Created by Филяев Илья on 31.10.2021.
//

import UIKit

class DetailCollectionVCell: UICollectionViewCell {

    @IBOutlet var imageView:UIImageView!
    
    static let identifier = "PhotoCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    // MARK: - Set image

    public func configure(with image: UIImage) {
        imageView.image = image
    }
    
    
    static func nib() -> UINib {
        return UINib(nibName: DetailCollectionVCell.identifier, bundle: nil)
    }
}
