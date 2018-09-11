//
//  UIOutlinedLabel.swift
//  SeeFruit
//
//  Created by Zain Budhwani on 9/9/18.
//  Copyright © 2018 Zain Budhwani. All rights reserved.
//

import UIKit

class UIOutlinedLabel: UILabel {
    
    var outlineWidth: CGFloat = 1
    var outlineColor: UIColor = UIColor.white
    
    override func drawText(in rect: CGRect) {
        
        let strokeTextAttributes : [NSAttributedStringKey : Any] = [
            .strokeColor : outlineColor,
            .strokeWidth : -1 * outlineWidth,
        ]
        
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: strokeTextAttributes)
        super.drawText(in: rect)
    }
}
