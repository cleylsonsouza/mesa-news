//
//  NewsItemCell.swift
//  Mesa News
//

import UIKit

class NewsItemCell: UITableViewCell {
    
    @IBOutlet weak var cardView: CustomUnselectableCard!
    @IBOutlet weak var imageBackgroundView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    override func awakeFromNib() {
        imageBackgroundView.clipsToBounds = true
        imageBackgroundView.layer.cornerRadius = 8
        imageBackgroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}
