//
//  RecipeCollectionVCell.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import UIKit
import SDWebImage

class RecipeCollectionVCell: UICollectionViewCell {
    
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var sourceRecipeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureRecipeCell(imageURL: String, titleRecipe: String, sourceRecipe: String ) {
        let url = URL(string: imageURL )
        imageRecipe.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageRecipe.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0), completed: nil)
        
        titleRecipeLabel.text = "\(titleRecipe)"
        sourceRecipeLabel.text = "Source: \(sourceRecipe)"
        
        
    }
}
