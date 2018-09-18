//
//  ExtensionUIResponder.swift
//  StructureApp
//
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:39 AM - (indianic)
//
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//
//

import Foundation
import UIKit


// MARK: - Extension of UIResponder For getting the ParentViewController(UIViewController) of any UIView.
extension UIResponder {
    
    /// This Property is used to getting the ParentViewController(UIViewController) of any UIView.
    var parentViewController:UIViewController? {
        
        if self.next is UIViewController {
            return self.next as? UIViewController
        } else {
            guard self.next != nil else { return nil }
            return self.next?.parentViewController
        }
    }
    
}
