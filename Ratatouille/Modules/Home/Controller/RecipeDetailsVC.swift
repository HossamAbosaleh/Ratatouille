//
//  RecipeDetailsVC.swift
//  Ratatouille
//
//  Created by Abo Saleh on 13/01/2023.
//

import UIKit
import SDWebImage
import SafariServices

class RecipeDetailsVC: UIViewController {
    
    // MARK: - IBOutlets.
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var totalWeightLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    // MARK: - Private Variables.
    var recipe: Recipe?
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recipe {
            fillRecipeData(recipe)
        }
        
    }
    
    // MARK: - Private Functions.
    private func fillRecipeData(_ recipe: Recipe?) {
        if let recipe {
            titleRecipeLabel.text = recipe.label.orEmpty
            let calories = String(format: "%.2F %@", recipe.calories ?? 0.0, "Cal")
            caloriesLabel.text = calories
            let totalWeight = String(format: "%.2F %@", recipe.totalWeight ?? 0.0, "g")
            totalWeightLabel.text = totalWeight
            totalTimeLabel.text = "\(recipe.totalTime.orEmpty) Min"
            
            let url = URL(string: recipe.image.orEmpty )
            recipeImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            recipeImageView.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0), completed: nil)
            
            print("Recipe Website", recipe.url.orEmpty)
        }
    }
    // MARK: - IBActions.
    
    @IBAction func recipeWebsiteAction(_ sender: UIButton) {
        
        guard let recipe = recipe else { return }
        
        let urlString = recipe.url.orEmpty

        if let url = URL(string: urlString) {
               let config = SFSafariViewController.Configuration()
               config.entersReaderIfAvailable = true
               let vc = SFSafariViewController(url: url, configuration: config)
               present(vc, animated: true)
           }
    }
}



extension RecipeDetailsVC: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}


