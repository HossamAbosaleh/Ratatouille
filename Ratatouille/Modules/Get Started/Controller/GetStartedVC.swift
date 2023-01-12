//
//  GetStartedVC.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import UIKit

class GetStartedVC: UIViewController {

    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - IBActions.
    @IBAction func getStartedAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") //as! TabBC
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
    }
}
