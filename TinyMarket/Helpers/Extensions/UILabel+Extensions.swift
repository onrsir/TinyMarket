//
//  UILabel+Extensions.swift
//  TinyMarket
//
//  Created by Onur Sır on 08.04.2023.
//
import Foundation
import UIKit


extension UILabel {
    func setBoldPart(boldText: String, normalText: String, normalFontSize: CGFloat? = nil, boldFontSize: CGFloat? = nil) {
        let normalFont = normalFontSize != nil ? UIFont.systemFont(ofSize: normalFontSize!) : UIFont.systemFont(ofSize: self.font.pointSize)
        let boldFont = boldFontSize != nil ? UIFont.boldSystemFont(ofSize: boldFontSize!) : UIFont.boldSystemFont(ofSize: self.font.pointSize)
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: normalFont,
            .foregroundColor: self.textColor
        ]
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: boldFont,
            .foregroundColor: self.textColor
        ]

        let attributedString = NSMutableAttributedString(string: normalText, attributes: normalAttributes)
        attributedString.append(NSAttributedString(string: boldText, attributes: boldAttributes))

        self.attributedText = attributedString
    }
}

