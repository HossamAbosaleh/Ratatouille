//
//  UICollectionView+Extensions.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//


import UIKit

extension UICollectionView {
    
    func registerCell<Cell:UICollectionViewCell>(cellClass: Cell.Type ){
    //MARK: - Generic Register CollectionView Cells
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: Cell.self))
    }
    
    
    func dequeue<Cell:UICollectionViewCell>(indexPath: IndexPath) -> Cell {
        //MARK: - Generic dequeueReusableCells
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell else { fatalError("Error in cell")}
    
        return cell
    }
    
    func setEmptyMessage(fileName: String = "empty_data") {
        let viewfromXib = LottieView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        viewfromXib.fileName = fileName
        backgroundView = viewfromXib
        
    }
     
}
