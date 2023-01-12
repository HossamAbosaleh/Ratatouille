//
//  SplashVC.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import UIKit

class SplashVC: UIViewController {

    // MARK: - IBOutlets.
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    // MARK: - Private Variables.
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        smallScale(goTo: "normalScale")
    }
    
    // MARK: - Private Functions.
    
    private func smallScale(goTo: String) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: { [self] in
            logoImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { [self] _ in
            if goTo == "normalScale" {
                normalScale()
            } else {
                bigScale()
            }
        })
    }
    
    private func normalScale() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: { [self] in
            logoImageView.transform = .identity
        }, completion: { [self] _ in
            smallScale(goTo: "bigScale")
        })
    }
    
    private func bigScale() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: { [self] in
            logoImageView.transform = CGAffineTransform(scaleX: 1000, y: 1000)
            logoImageView.alpha = 0
            view.backgroundColor = .white
        }, completion: { [self] _ in
            navigate()
        })
    }
    
    private func navigate() {
        let vc = UIStoryboard(name: "GetStarted", bundle: nil).instantiateViewController(withIdentifier: "GetStartedVC") //as! TabBC
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
}


