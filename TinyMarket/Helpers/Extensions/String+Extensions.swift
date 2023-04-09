//
//  String+Extensions.swift
//  TinyMarket
//
//  Created by Onur Sır on 08.04.2023.
//

import Foundation
import UIKit

extension String {
    
    static var empty: Self {
        ""
    }
    
    static var whiteSpace: Self {
        " "
    }
    
    func getTextHeight(font:UIFont, width:CGFloat) -> CGFloat {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.height
    }
    
    func getTextWidth(font: UIFont) -> CGFloat {
        
        let label = UILabel()
        label.numberOfLines = 1
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.width
    }
}
