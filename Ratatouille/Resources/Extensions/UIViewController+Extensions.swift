//
//  UIViewController+Extensions.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import UIKit
import SwiftMessages

extension UIViewController {
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    @available(iOS 13.0, *)
    var sceneDelegate: SceneDelegate? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return nil }
        return delegate
    }
    
    var window: UIWindow? {
        if #available(iOS 13, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
            return window
        }
        //guard let delegate = UIApplication.shared.delegate as? AppDelegate, let window = delegate.window else { return nil }
        return self.window
    }
    
    func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
    
    
    func swiftMessage(title: String, body: String, color: Theme, layout: MessageView.Layout, style: SwiftMessages.PresentationStyle) {
        let view = MessageView.viewFromNib(layout: layout)
        view.configureTheme(color)
        view.configureDropShadow()
        view.configureContent(title: title, body: body)
        view.button?.isHidden = true
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = style
        config.dimMode = .gray(interactive: true)
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        config.duration = .forever
        SwiftMessages.show(config: config, view: view)
    }
    
    func getRootVC()-> UIViewController {
        let viewController = window?.topViewController()
        return viewController!
    }
    
    func setRootVC(storyboard: String, vcIdentifier: String, embed: Bool = false) {
        let vc = UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: vcIdentifier)
        if embed {
            let nav = UINavigationController()
            nav.viewControllers = [vc]
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }else {
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
    }
    
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func moveViewWithKeyboard(notification: NSNotification, viewBottomConstraint: NSLayoutConstraint, keyboardWillShow: Bool) {
        // Keyboard's size
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardSize.height
        
        // Keyboard's animation duration
        let keyboardDuration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        // Keyboard's animation curve
        let keyboardCurve = UIView.AnimationCurve(rawValue: notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)!
        
        // Change the constant
        if keyboardWillShow {
            let safeAreaExists = (self.view?.window?.safeAreaInsets.bottom != 0) // Check if safe area exists
            let bottomConstant: CGFloat = 20
            viewBottomConstraint.constant = keyboardHeight + (safeAreaExists ? 0 : bottomConstant)
        }else {
            viewBottomConstraint.constant = 20
        }
        
        // Animate the view the same way the keyboard animates
        let animator = UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) { [weak self] in
            // Update Constraints
            self?.view.layoutIfNeeded()
        }
        
        // Perform the animation
        animator.startAnimation()
    }
}
