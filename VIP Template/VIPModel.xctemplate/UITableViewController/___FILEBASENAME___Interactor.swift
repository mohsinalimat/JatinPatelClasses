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

protocol ___VARIABLE_sceneName___InteractorProtocol {
    func doSomething()
}

protocol ___VARIABLE_sceneName___DataStore {
    //var name: String { get set }
}

class ___VARIABLE_sceneName___Interactor: ___VARIABLE_sceneName___InteractorProtocol, ___VARIABLE_sceneName___DataStore {
    var presenter: ___VARIABLE_sceneName___PresentationProtocol?
    //var name: String = ""
    
    // MARK: Do something
    func doSomething() {
        
    }
}
