//
//  HighlightsDetailItemCell.swift
//  Mesa News
//

import UIKit

class HighlightsDetailItemCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundDetailView: UIView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundDetailView.clipsToBounds = true
        backgroundDetailView.layer.cornerRadius = 8
        backgroundDetailView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = 8
        backgroundImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}
