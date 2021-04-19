//
//  HighlightsItemCell.swift
//  Mesa News
//

import UIKit

class HighlightsItemCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate> (dataSourceDelegate: D) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.reloadData()
    }
}
