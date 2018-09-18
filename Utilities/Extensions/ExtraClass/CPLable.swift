//
//  CPLable.swift
//  Lowda
//
//  Created by indianic on 30/11/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class CPLable: UILabel {

    override var text: String? {
        didSet{
            setUpLanguage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLanguage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUpLanguage()
    }
    
    private func setUpLanguage(){
        
        guard let aStrTitle = LanguageUtility.sharedInstance.getLocalizedString(text!) else {
            print(" ========================== \(String(describing: text!)) NOT FOUND IN Language FILE ==========================")
            return }
        
        //Stop infinity loop generated from didSet
        guard aStrTitle != text! else { return }
        
        text = aStrTitle
    }

}
