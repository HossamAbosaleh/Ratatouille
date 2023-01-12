//
//  Loading.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import UIKit
import Lottie

class Loading: NSObject {
    
    private var overlayView: UIView!
    private var animationView: LottieAnimationView?
    private let width = 64
    private let height = 64
    
    func startProgress(_ viewController: UIViewController) {
        finishProgress(viewController)
        overlayView = UIView(frame: UIScreen.main.bounds)
        overlayView.tag = 24111994
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        viewController.view.addSubview(overlayView)
        animationView = .init(name: "loading")
        animationView?.backgroundColor = .white
        animationView?.cornerRadius = 10
        animationView?.frame = CGRect(x: 0, y: 0, width: width, height: height)
        animationView?.center = CGPoint(x: overlayView.frame.midX, y: overlayView.frame.midY)
        animationView?.backgroundBehavior = .pauseAndRestore
        animationView?.contentMode = .scaleAspectFill
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1
        overlayView.addSubview(animationView!)
        animationView?.play()
    }
    
    func finishProgress(_ viewController: UIViewController) {
        animationView?.stop()
        animationView?.removeFromSuperview()
        viewController.view.viewWithTag(24111994)?.removeFromSuperview()
    }
    
}
