//
//  HomeVC.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - IBOutlets.
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var recipeCollectionView: UICollectionView!
    
    // MARK: - Private Variables.
    private var filterCViewItems = [String]()
    private var fieldsParameters = [String]()
    private var recipeCViewItems = [HitsModel]()
    private var selectIndexInFilter: Int?
    private var textSearch: String = ""
    private var textFilter: String = ""
    private var from_page: Int?
    private var to_page: Int?
    private var next_Link: String?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Functions.
    private func setupUI() {
        setupCollectionViews()
        searchBar.delegate = self
        fieldsParameters = ["label","image","images","source","url", "shareAs","calories", "totalWeight", "totalTime"]
        filterCViewItems = ["All", "low-sugar", "keto-friendly", "vegan"]
    }
    
    private func setupCollectionViews() {
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        
        recipeCollectionView.delegate = self
        recipeCollectionView.dataSource = self
        
        registerCells()
    }
    
    private func registerCells() {
        filterCollectionView.registerCell(cellClass: FilterCollectionVCell.self)
        recipeCollectionView.registerCell(cellClass: RecipeCollectionVCell.self)
        recipeCollectionView.registerCell(cellClass: LoadingCollectionVCell.self)
        
    }
    
    
    // MARK: - IBActions.
    
}

// MARK: - UICollectionView DataSource.
extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case filterCollectionView:
            return filterCViewItems.count
        case recipeCollectionView:
            if recipeCViewItems.count == 0 {
                recipeCollectionView.setEmptyMessage()
            } else {
                recipeCollectionView.backgroundView = nil
                return recipeCViewItems.count
            }
        default:
            break
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case filterCollectionView:
            
            let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionVCell", for: indexPath) as! FilterCollectionVCell
            let item = filterCViewItems[indexPath.row]
            let isSelected = (selectIndexInFilter == indexPath.row) ? true : false
            
            filterCell.configureFilterCell(filterTitle: item, isSelected)
            
            return filterCell
            
        case recipeCollectionView:
            
            let recipeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCollectionVCell", for: indexPath) as! RecipeCollectionVCell
            
            let loadingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCollectionVCell", for: indexPath) as! LoadingCollectionVCell
            
            guard let from_page = from_page, let to_page = to_page else { return UICollectionViewCell() }
            
            if from_page < to_page && indexPath.row == recipeCViewItems.count - 1 {
                loadingCell.configureLoadingCell()
                
                return loadingCell
            } else {
                let item = recipeCViewItems[indexPath.row]
                if let recipe = item.recipe {
                    recipeCell.configureRecipeCell(imageURL: recipe.image.orEmpty, titleRecipe: recipe.label.orEmpty, sourceRecipe: recipe.source.orEmpty)
                }
                
                return recipeCell
            }
            
        default:
            break
        }
        return UICollectionViewCell()
    }
    
}

// MARK: - UICollectionView Delegate & DelegateFlowLayout.
extension HomeVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
            
        case filterCollectionView:
            
            selectIndexInFilter = indexPath.row
            filterCollectionView.reloadData()
            textFilter = filterCViewItems[selectIndexInFilter ?? 0]
            recipeCViewItems.removeAll()
            recipeCollectionView.reloadData()
            getRecipe(textSearch, and: textFilter )
            
        case recipeCollectionView:
            
            let item = recipeCViewItems[indexPath.row]
            if let recipe = item.recipe {
                let vc = UIStoryboard(name:  "Home", bundle: nil).instantiateViewController(withIdentifier: "RecipeDetailsVC") as! RecipeDetailsVC
                vc.title = "Recipe Details"
                vc.recipe = recipe
                navigationController?.pushViewController(vc, animated: true)
            }
            
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case filterCollectionView :
            
            let height = (collectionView.bounds.height)
            let width = ((filterCViewItems[indexPath.row].widthOfString(usingFont: UIFont.systemFont(ofSize: 19, weight: .regular)) ) + 56)
            
            return CGSize(width: width, height: height)
            
        case recipeCollectionView:
            let height = 260.0
            let width = (collectionView.bounds.width )
            
            return CGSize(width: width, height: height)
            
        default:
            break
        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == recipeCollectionView {
            if let from_page, let to_page, let next_Link {
                if from_page < to_page && indexPath.row == recipeCViewItems.count - 1 {
                    if selectIndexInFilter != nil {
                        getRecipe(textSearch, and: textFilter, link: next_Link, showLoading: false)
                    } else {
                        getRecipe(textSearch, link: next_Link, showLoading: false)
                    }
                }
            }
        }
    }
}

// MARK: - UISearchBarDelegate.
extension HomeVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            textSearch = text
            if selectIndexInFilter != nil {
                getRecipe(textSearch, and: textFilter)
            } else {
                recipeCViewItems.removeAll()
                self.recipeCollectionView.reloadData()
                getRecipe(textSearch)
            }
            
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            self.recipeCViewItems.removeAll()
            self.recipeCollectionView.reloadData()
            textSearch = ""
            textFilter = ""
            selectIndexInFilter = nil
            filterCollectionView.reloadData()
        }
    }
}

// MARK: - APi.
extension HomeVC  {
    func getRecipe(_ search: String, and filter: String? = nil, link: String? = Endpoints.BASE_API_URL, showLoading: Bool = true)  {
        
        var parameters = [
            "type": Constants.Parameters.type.rawValue,
            "app_id": Constants.Parameters.app_id.rawValue,
            "app_key": Constants.Parameters.app_key.rawValue,
            "q": search,
            "field": fieldsParameters
        ] as [String : Any]
        if let filter {
            parameters["health"] = filter
        }
        if let filter {
            parameters["health"] = filter
        }
        if let filter = filter {
            parameters["health"] = filter
        }
        if let filter = filter {
            if filter == "All" {
                for filter in filterCViewItems {
                    parameters["health"] = filter
                }
            }
        }
        
        NetworkManager.instance.request(link.orEmpty, parameters: parameters, method: .get, type: [HitsModel].self, viewController: self, api_response: { [self] (data) in
            success(data: data)
        },hasLoading: showLoading)
    }
    
    private func success(data: BaseModel<[HitsModel]>?) {
       
        DispatchQueue.main.async { [self] in
            recipeCViewItems.append(contentsOf: data?.data ?? [])
            recipeCollectionView.reloadData()
        }
        self.from_page = data?.from
        self.to_page = data?.to
        self.next_Link = data?._links?.next?.href.orEmpty
    }
}


