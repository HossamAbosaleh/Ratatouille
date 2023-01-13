//
//  FilterCollectionVCell.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import UIKit

class FilterCollectionVCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundLabelView: UIView!
    
    @IBOutlet weak var filterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureFilterCell(filterTitle: String, _ isSelected: Bool ) {
        
        filterLabel.text = filterTitle
        
        if isSelected {
            backgroundLabelView.backgroundColor = UIColor.appColor(Constants.AssetsColor.PrimaryColor)
            filterLabel.textColor = .white
            filterLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        } else {
            backgroundLabelView.backgroundColor = UIColor.appColor(Constants.AssetsColor.SecondaryColor)
            filterLabel.textColor = .black
            filterLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        }
    }
}
