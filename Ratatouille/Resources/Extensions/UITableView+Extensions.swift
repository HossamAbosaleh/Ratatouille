//
//  UITableView+Extensions.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//


import UIKit

extension UITableView {
    
    func registerTVCell<Cell:UITableViewCell>(cellClass: Cell.Type){
        //MARK: - Generic Register TableView Cells
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: String(describing: Cell.self))
    }
    
    func dequeueTVCell<Cell:UITableViewCell>() -> Cell {
        //MARK: - Generic dequeueReusableTableViewCells
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {  fatalError("Error in Cell") }
        return cell
    }
        
}
