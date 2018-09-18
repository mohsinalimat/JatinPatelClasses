//
//  UIApplicationExtensions.swift
//  EZSwiftExtensions
//
//  Created by Mousavian on 23/02/16.
//  Copyright (c) 2016 Lucas Farah. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit

extension UIApplication {
    /// EZSE: Run a block in background after app resigns activity
    public func runInBackground(_ closure: @escaping () -> Void, expirationHandler: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let taskID: UIBackgroundTaskIdentifier
            if let expirationHandler = expirationHandler {
                taskID = self.beginBackgroundTask(expirationHandler: expirationHandler)
            } else {
                taskID = self.beginBackgroundTask(expirationHandler: { })
            }
            closure()
            self.endBackgroundTask(taskID)
        }
    }

    /// EZSE: Get the top most view controller from the base view controller; default param is UIWindow's rootViewController
    public class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}

#endif


extension UIApplication {
    
    var topMostViewController: UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }
    
    var topMostNavigationController: UINavigationController? {
        return topMostViewController as? UINavigationController
    }
    
    /// App has more than one window and just want to get topMostViewController of the AppDelegate window.
    var appDelegateWindowTopMostViewController: UIViewController? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        var topController = delegate?.window?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }
}


/**
 Description: the toppest view controller of presenting view controller
 How to use:  UIApplication.sharedApplication().keyWindow?.rootViewController?.topMostViewController
 Where to use: There are lots of kinds of controllers (UINavigationControllers, UITabbarControllers, UIViewController)
 */

extension UIViewController {
    
    @objc var topMostViewController: UIViewController? {
        // Handling Modal views
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController
        }
            // Handling UIViewController's added as subviews to some other views.
        else {
            for view in self.view.subviews
            {
                // Key property which most of us are unaware of / rarely use.
                if let subViewController = view.next {
                    if subViewController is UIViewController {
                        let viewController = subViewController as! UIViewController
                        return viewController.topMostViewController
                    }
                }
            }
            return self
        }
    }
}

extension UITabBarController {
    
    override var topMostViewController: UIViewController? {
        return self.selectedViewController?.topMostViewController
    }
    
    var topVisibleViewController: UIViewController? {
        var top = selectedViewController
        while top?.presentedViewController != nil {
            top = top?.presentedViewController
        }
        return top
    }
}

extension UINavigationController {
    override var topMostViewController: UIViewController? {
        return self.visibleViewController?.topMostViewController
    }
}
