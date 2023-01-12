//
//  CheckConnectionVC.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import Foundation

import UIKit
import Lottie

class CheckConnection: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupAnimation()
    }
    
    private func setupAnimation() {
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 2
        animationView.play()
    }

    // MARK: - IBAction
    @IBAction func tryAgainAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SplashVC") 
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }

}
