//
//  StoryBoardConstant.swift
//  Glyff
//
//  Created by indianic on 04/05/18.
//  Copyright © 2018 Indianic. All rights reserved.
//

import UIKit

struct ViewControllerID {

    public static let loginVC =  "LoginVC"
    public static let forgotPasswordVC =  "ForgotPasswordVC"
    public static let roleSelectionVC =  "RoleSelectionVC"
    
    public static let compleateProfileVC = "CompleateProfileVC"
    public static let completeProfileTwoVC =  "CompleteProfileTwoVC"
    public static let signUpVC =  "SignUpVC"
    
    public static let userProfileVC = "UserProfileVC"
    public static let viewUserProfileVC = "ViewUserProfileVC"
    
    
    public static let termsConditionVC = "TermsConditionVC"
    public static let countryListVC = "CountryListVC"

    public static let filterVC = "FilterVC"


    public static let discoverVC = "DiscoverVC"
    public static let discoverDetailProfileVC = "DiscoverDetailProfileVC"
    public static let discoverVideoPlayerVC = "DiscoverVideoPlayerVC"
    
    public static let connectionVC = "ConnectionsVC"
    
    
    public static let tutorialPageViewController = "TutorialPageViewController"
    public static let tutorialScreenOneVC = "TutorialScreenOneVC"
    public static let tutorialScreenTwoVC = "TutorialScreenTwoVC"
    public static let tutorialScreenThreeVC = "TutorialScreenThreeVC"
    public static let tutorialScreenFourVC = "TutorialScreenFourVC"
    
    public static let sideMenuVC = "SideMenuVC"
    public static let reportAbuseVC = "ReportAbuseVC"
    public static let settingsVC =  "SettingsVC"
    public static let changePasswordVC =  "ChangePasswordVC"

    public static let notificationsVC = "NotificationsVC"
    public static let attorneyListVC = "AttorneyListVC"
    public static let attorneyFilterVC = "AttorneyFilterVC"
    public static let attorneyCompleteProfileVC = "AttorneyCompleteProfileVC"
    public static let editUserProfileVC = "EditUserProfileVC"
    public static let attorneyDashboardVC = "AttorneyDashboardVC"
    public static let attornyProfileDetailVC = "AttornyProfileDetailVC"
    public static let chatVC = "ChatVC"
    public static let chatListVC = "ChatListVC"
    
    public static let rateListVC = "RateListVC"
    public static let rateUsVC = "RateUsVC"
    
    public static let premiumPopUpVC = "PremiumPopUpVC"
    
    

}

struct StoryBoardID {
    
    public static let launchScreen = "LaunchScreen"
    public static let main = "Main"
    public static let walkthrough =  "Walkthrough"
    public static let roleSelection =  "RoleSelection"
    public static let dashboard =  "Dashboard"
    public static let discoverHome =  "DiscoverHome"
    public static let settings =  "Settings"
    public static let attorney =  "Attorney"
    public static let chat =  "Chat"
    

}

struct cellIdentifire {
    
    public static let discoverCollectionViewCell = "DiscoverCollectionViewCell"
    public static let connectionsCollectionCell = "ConnectionsCollectionCell"
    public static let attorneyNameTableCell = "AttorneyNameTableCell"
    public static let attorneyAboutTableCell = "AttorneyAboutTableCell"
    public static let attorneyReviewTableCell = "AttorneyReviewTableCell"
    public static let attorneyRateNowTableCell = "AttorneyRateNowTableCell"
    public static let attorneyListTableCell = "AttorneyListTableCell"
    public static let reportAbuseTableCell = "ReportAbuseTableCell"
    public static let sideMenuUserInfoTableCell = "SideMenuUserInfoTableCell"
    public static let sideMenuTableCell = "SideMenuTableCell"
    public static let countryListTableCell = "CountryListTableCell"
    public static let rateListTableCell = "RateListTableCell"
    public static let rateNowTableCell = "RateNowTableCell"
    public static let attorneyDashboardTableCell = "AttorneyDashboardTableCell"
    

    
}

// Create Meme View Controllers

//struct CreateMeme {
//    public static let CameraViewController = { () -> UIViewController in
//        let cameraStoryBoard = UIStoryboard.init(name: StoryBoardID.CreateMeme, bundle: nil)
//        let cameraNav: UINavigationController = cameraStoryBoard.instantiateViewController(withIdentifier: ViewControllerID.CameraNavigationController) as! UINavigationController
//        cameraNav.hideNavigationBar = true
//        return cameraNav
//    }
//
//    public static let CropMemeViewController = { () -> MemeCropVC in
//    let cameraStoryBoard = UIStoryboard.init(name: StoryBoardID.CreateMeme, bundle: nil)
//        let objMemeCropVC = cameraStoryBoard.instantiateViewController(withIdentifier: ViewControllerID.MemeCropVC) as! MemeCropVC
//        return objMemeCropVC
//    }
//
//    public static let AddCaptionViewController = { () -> AddCaptionVC in
//        let cameraStoryBoard = UIStoryboard.init(name: StoryBoardID.CreateMeme, bundle: nil)
//        let objAddCaptionVC = cameraStoryBoard.instantiateViewController(withIdentifier: ViewControllerID.AddCaptionVC) as! AddCaptionVC
//        return objAddCaptionVC
//    }
//
//    public static let LibraryViewController = { () -> UIViewController in
//        let cameraStoryBoard = UIStoryboard.init(name: StoryBoardID.CreateMeme, bundle: nil)
//        let libraryNav = cameraStoryBoard.instantiateViewController(withIdentifier: ViewControllerID.LibraryNavController) as! UINavigationController
//        libraryNav.hideNavigationBar = true
//        return libraryNav
//    }
//
//    public static let SearchInternetViewController = { () -> UIViewController in
//        let cameraStoryBoard = UIStoryboard.init(name: StoryBoardID.CreateMeme, bundle: nil)
//        let searchInternetNav = cameraStoryBoard.instantiateViewController(withIdentifier: ViewControllerID.SearchInternetNavController) as! UINavigationController
//        searchInternetNav.hideNavigationBar = true
//        return searchInternetNav
//    }
//}


