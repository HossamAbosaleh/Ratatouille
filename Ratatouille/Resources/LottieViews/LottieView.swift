//
//  LottieView.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import UIKit
import Lottie

class LottieView: UIView {
    
    let nibName = "LottieView"
    
    private var animationView: LottieAnimationView?
    
    var fileName: String? {
        didSet {
            animationView = .init(name: fileName ?? "empty_data")
            if let animationView = animationView {
                animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                animationView.center = center
                animationView.backgroundBehavior = .pauseAndRestore
                animationView.contentMode = .scaleAspectFit
                animationView.loopMode = .loop
                animationView.animationSpeed = 1
                addSubview(animationView)
                animationView.play()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }

    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}


