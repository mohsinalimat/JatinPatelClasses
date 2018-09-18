//
//  UINavigationControllerExtensions.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:31 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  


import Foundation
import UIKit

// MARK: - Methods
public extension UINavigationController {
    
//    /// Pop ViewController with completion handler.
//    ///
//    /// - Parameter completion: optional completion handler (default is nil).
//    public func popViewController(_ completion: (() -> Void)? = nil) {
//        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
//        CATransaction.begin()
//        CATransaction.setCompletionBlock(completion)
//        popViewController(animated: true)
//        CATransaction.commit()
//    }
//
//    /// Push ViewController with completion handler.
//    ///
//    /// - Parameters:
//    ///   - viewController: viewController to push.
//    ///   - completion: optional completion handler (default is nil).
//    public func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
//        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
//        CATransaction.begin()
//        CATransaction.setCompletionBlock(completion)
//        pushViewController(viewController, animated: true)
//        CATransaction.commit()
//    }
    
    /// Make navigation controller's navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    public func makeTransparent(withTint tint: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tint
        navigationBar.titleTextAttributes = [.foregroundColor: tint]
    }
    
    public func cpConfiguredNavigationBar(isHidden:Bool,titleText:String?,viewController:UIViewController?) {
        
        self.isNavigationBarHidden = isHidden
        viewController?.navigationItem.hidesBackButton = true
        viewController?.title = titleText!
        let frame = CGRect(x: 0, y: 5, width: 200, height: 40)
        let tlabel = UILabel(frame: frame)
        tlabel.text = viewController?.title
        tlabel.textColor = UIColor.colorFromCode(0x38CA73)
        tlabel.font = UIFont(name: "OpenSans-Regular.ttf", size: 22.0)
        tlabel.backgroundColor = UIColor.clear
        tlabel.adjustsFontSizeToFitWidth = true
        tlabel.textAlignment = .center
        viewController?.navigationItem.titleView = tlabel
        self.navigationBar.setColors(background: UIColor.colorFromCode(0xFFFFFF), text: .colorFromCode(0x38CA73))
        self.navigationBar.shadowImage = UIImage()
        
    } 
    
}
