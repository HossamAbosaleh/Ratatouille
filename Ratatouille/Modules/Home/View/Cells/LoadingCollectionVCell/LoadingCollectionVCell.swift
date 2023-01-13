//
//  LoadingCollectionVCell.swift
//  Ratatouille
//
//  Created by Abo Saleh on 13/01/2023.
//

import UIKit

class LoadingCollectionVCell: UICollectionViewCell {

    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureLoadingCell() {
        actIndicator.startAnimating()
    }

}
