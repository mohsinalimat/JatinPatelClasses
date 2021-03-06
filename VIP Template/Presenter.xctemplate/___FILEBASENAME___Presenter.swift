//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ___VARIABLE_sceneName___PresentationProtocol {
    func presentSomething()
}

class ___VARIABLE_sceneName___Presenter: ___VARIABLE_sceneName___PresentationProtocol {
    weak var viewController: ___VARIABLE_sceneName___Protocol?
    var interactor: ___VARIABLE_sceneName___InteractorProtocol?
    
    // MARK: Present something
    func presentSomething() {
        
    }
}
