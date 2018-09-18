//
//  LoginViewModel.swift
//  LoveInternational
//
//  Created by indianic on 23/07/18.
//  Copyright © 2018 indianic. All rights reserved.
//


import Foundation
import UIKit
import SwiftMessages

public class MessageBar {
    
    
    
    /// This method will used to display a Message Bar on the screen.
    /// 
    /// 	MessageBar.show(.info, title: "OPTIONAL TITLE", message: "YOUR MESSAGE HERE")
    /// 	MessageBar.show(.success, title: "OPTIONAL TITLE", message: "YOUR MESSAGE HERE")
    /// 	MessageBar.show(.warning, title: "OPTIONAL TITLE", message: "YOUR MESSAGE HERE")
    /// 	MessageBar.show(.error, title: "OPTIONAL TITLE", message: "YOUR MESSAGE HERE")
    /// 
    /// - Parameters:
    ///   - theme: Type of Message Bar you wanted to display. There are 4 types available. - error | success | warning | info
    ///   - title: String Title you wanted to display on message. Pass nil here if you wanted to display default title based on the theme. If value if this param is passed then it will override the default title.
    ///   - message: String Message you wanted to display on message.
    public class func show(_ theme: Theme, title: String? = nil, message: String,buttonHide:Bool = true, buttonTitle:String = "", alertDuretion:SwiftMessages.Duration = .seconds(seconds: 4)) -> Void {
        
        // -- View setup
        let view: MessageView = MessageView.viewFromNib(layout: .cardView)
        
//        DispatchQueue.main.async {
//            SwiftMessages.show(config: config, view: view)
//        }
        
        view.backgroundView.cornerRadius = 12.0
        
        view.configureContent(title: "Info", body: message.localized, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: buttonTitle, buttonTapHandler: { _ in SwiftMessages.hide() })
        
        // Icon Style
        let iconStyle: IconStyle = .default
        
        // Theme
        switch theme {
        case .info:
            
            view.configureTheme(backgroundColor: UIColor.colorFromCode(0x017FA4), foregroundColor: .white, iconImage: iconStyle.image(theme: .info), iconText: nil)
            
            view.titleLabel?.text = title ?? ""
        case .success:
            view.configureTheme(backgroundColor: UIColor.colorFromCode(0x00C853), foregroundColor: .white, iconImage: iconStyle.image(theme: .success), iconText: nil)
            view.titleLabel?.text = title ?? ""
        case .warning:
            view.configureTheme(backgroundColor: UIColor.colorFromCode(0xFFAB00), foregroundColor: .white, iconImage: iconStyle.image(theme: .warning), iconText: nil)
            view.titleLabel?.text = title ?? ""
        case .error:
            view.configureTheme(backgroundColor: UIColor.colorFromCode(0xFC2125), foregroundColor: .white, iconImage: iconStyle.image(theme: .error), iconText: nil)
            view.titleLabel?.text = title ?? ""
        }

        // view.titleLabel?.text = ""
        
        //        if title != nil {
        //            view.titleLabel?.text = title!
        //        }
        
        // Set Font
        view.bodyLabel?.font = UIFont(name: "OpenSans-Bold", size: 15.0)
        view.titleLabel?.font = UIFont(name: "OpenSans-SemiBold", size: 14.0)

        
        // Add a drop shadow.
        view.configureDropShadow()
        
        // Set Button
        view.button?.isHidden = buttonHide
        
        // Show Icon
        view.iconImageView?.isHidden = false
        view.iconLabel?.isHidden = false
        
        // Show Title
        view.titleLabel?.isHidden = false
        
        // Show Body
        view.bodyLabel?.isHidden = false
        
        
        // -- Config setup
        
        var config = SwiftMessages.defaultConfig
        
        // Presentation
        config.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        
        // Duration
        config.duration = alertDuretion
        
        // Rotation
        config.shouldAutorotate = true
        
        // Disable the interactive pan-to-hide gesture.
        config.interactiveHide = true
        
        // Specify a status bar style to if the message is displayed directly under the status bar.
        config.preferredStatusBarStyle = .lightContent
        
        
        
        // Show Message Bar
        DispatchQueue.main.async {
            SwiftMessages.show(config: config, view: view)
        }
        
    }
    
    /// This method will hide all the Messages which are displayed and also clear the queue.
    public class func hide() -> Void {
        SwiftMessages.hideAll()
    }
    
}
