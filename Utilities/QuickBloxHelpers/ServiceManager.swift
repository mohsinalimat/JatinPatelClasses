//
//  ServiceManager.swift
//  JoySalesApp
//
//  Created by indianic on 22/06/18.
//  Copyright © 2018 indianic. All rights reserved.
//

import UIKit
import Foundation
import QMServices

class ServicesManager: QMServicesManager {
    
    //MARK:- Properties
    
    var currentDialogID = ""
    var isProcessingLogOut: Bool!
    
    var colors = [
        UIColor(red: 0.992, green:0.510, blue:0.035, alpha:1.000),
        UIColor(red: 0.039, green:0.376, blue:1.000, alpha:1.000),
        UIColor(red: 0.984, green:0.000, blue:0.498, alpha:1.000),
        UIColor(red: 0.204, green:0.644, blue:0.251, alpha:1.000),
        UIColor(red: 0.580, green:0.012, blue:0.580, alpha:1.000),
        UIColor(red: 0.396, green:0.580, blue:0.773, alpha:1.000),
        UIColor(red: 0.765, green:0.000, blue:0.086, alpha:1.000),
        UIColor.red,
        UIColor(red: 0.786, green:0.706, blue:0.000, alpha:1.000),
        UIColor(red: 0.740, green:0.624, blue:0.797, alpha:1.000)
    ]
    
    var notificationService: NotificationService!
    
    //MARK:- Initialization
    
    override init() {
        super.init()
        self.setupContactServices()
        self.isProcessingLogOut = false
    }
    
    private func setupContactServices() {
        self.notificationService = NotificationService()
    }
    
    func handleNewMessage(message: QBChatMessage, dialogID: String) {
        
        guard self.currentDialogID != dialogID else {
            return
        }
        guard message.senderID != self.currentUser.id else {
            return
        }
        guard let dialog = self.chatService.dialogsMemoryStorage.chatDialog(withID: dialogID) else {
            print("chat dialog not found")
            return
        }
        
        var dialogName = "SA_STR_NEW_MESSAGE".localized
        if dialog.type != QBChatDialogType.private {
            
            if dialog.name != nil {
                dialogName = dialog.name!
            }
        } else {
            if let user = ServicesManager.instance().usersService.usersMemoryStorage.user(withID: UInt(dialog.recipientID)) {
                dialogName = user.login!
            }
        }
        print(dialogName)
    }
    
    //MARK:- Last activity date
    
    var lastActivityDate: NSDate? {
        get {
            let defaults = UserDefaults
            return defaults.value(forKey: "SA_STR_LAST_ACTIVITY_DATE".localized) as! NSDate?
        }
        set {
            let defaults = UserDefaults
            defaults.set(newValue, forKey: "SA_STR_LAST_ACTIVITY_DATE".localized)
            defaults.synchronize()
        }
    }
    
    //MARK:- QMServiceManagerProtocol
    
    override func handleErrorResponse(_ response: QBResponse) {
        super.handleErrorResponse(response)
        
        guard self.isAuthorized else {
            return
        }
        
        var errorMessage : String
        
        if response.status.rawValue == 502 {
            errorMessage = "SA_STR_BAD_GATEWAY".localized
        } else if response.status.rawValue == 0 {
            errorMessage = "SA_STR_NETWORK_ERROR".localized
        } else {
            
            errorMessage = (response.error?.error?.localizedDescription.replacingOccurrences(of: "(", with: "", options: String.CompareOptions.caseInsensitive, range: nil).replacingOccurrences(of: ")", with: "", options: String.CompareOptions.caseInsensitive, range: nil))!
        }
        print("ERROR",errorMessage)
       // JSMessageBar.show(.error , message: "SomethingWentWrong".localized)
    }
    
    func color(forUser user:QBUUser) -> UIColor {
        
        let defaultColor = UIColor.black
        
        let users = self.usersService.usersMemoryStorage.unsortedUsers()
        
        guard let givenUser = self.usersService.usersMemoryStorage.user(withID: user.id) else {
            return defaultColor
        }
        
        let indexOfGivenUser = users.index(of: givenUser)
        
        if indexOfGivenUser! < self.colors.count {
            return self.colors[indexOfGivenUser!]
        } else {
            return defaultColor
        }
    }
    
    /// Function to get sorted users from usersMemoryStorage
    func sortedUsers() -> [QBUUser]? {
        
        let unsortedUsers = self.usersService.usersMemoryStorage.unsortedUsers()
        
        let sortedUsers = unsortedUsers.sorted(by: { (user1, user2) -> Bool in
            return user1.login!.compare(user2.login!, options:NSString.CompareOptions.numeric) == ComparisonResult.orderedAscending
        })
        
        return sortedUsers
    }
    
    /// Function to get sorted users without current user
    func sortedUsersWithoutCurrentUser() -> [QBUUser]? {
        
        guard let sortedUsers = self.sortedUsers() else {
            return nil
        }
        
        let sortedUsersWithoutCurrentUser = sortedUsers.filter({ $0.id != self.currentUser.id})
        
        return sortedUsersWithoutCurrentUser
    }
    
    // MARK: QMChatServiceDelegate
    
    override func chatService(_ chatService: QMChatService, didAddMessageToMemoryStorage message: QBChatMessage, forDialogID dialogID: String) {
        
        super.chatService(chatService, didAddMessageToMemoryStorage: message, forDialogID: dialogID)
        
        if self.authService.isAuthorized {
            self.handleNewMessage(message: message, dialogID: dialogID)
        }
    }
    
    // MARK: LogOut from QuickBlox
    
    func logoutUserWithCompletion(completion: @escaping (_ result: Bool)->()) {
        
        if self.isProcessingLogOut! {
            
            completion(false)
            return
        }
        
        self.isProcessingLogOut = true
        
        let logoutGroup = DispatchGroup()
        
        logoutGroup.enter()
        
        let deviceIdentifier = UIDevice.current.identifierForVendor!.uuidString
        
        QBRequest.unregisterSubscription(forUniqueDeviceIdentifier: deviceIdentifier, successBlock: { (response) -> Void in
            
            print("Successfuly unsubscribed from push notifications")
            logoutGroup.leave()
            
        }) { (error) -> Void in
            
            print("Push notifications unsubscribe failed")
            logoutGroup.leave()
        }
        
        logoutGroup.notify(queue: DispatchQueue.main) { [weak self] () -> Void in
            
            // Logouts from Quickblox, clears cache.
            guard let strongSelf = self else { return }
            
            strongSelf.logout {
                
                strongSelf.isProcessingLogOut = false
                
                completion(true)
            }
        }
    }
}

