//
//  SharedHandler.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import Foundation
import UIKit

class SharedHandler {
    
    static let instance = SharedHandler()
    
    func getRootVC()-> UIViewController {
        
        if #available(iOS 13.0, *) {
            let sceneDelegate = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.delegate as! SceneDelegate
            let viewController = sceneDelegate.window?.topViewController()
            return viewController!
        } else {
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            let viewController = appDelegate.window?.topViewController()
            return viewController!
        }
    }
}
