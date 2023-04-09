//
//  LocalizationManager.swift
//  ToptanPiyasa
//
//  Created by Onur Sır on 13.01.2023.
//


import Foundation

final class LocalizationManager {
    
    static let shared = LocalizationManager()
    
    private var languageType: LanguageType = .turkish
    
    private init() { }
    
    func string(for localizationKeys: LocalizationKey) -> String {
        
        guard let path = Bundle.main.path(forResource: languageType.resource , ofType: "lproj"),
              let bundle = Bundle(path: path) else { return localizationKeys.rawValue }
        
        return NSLocalizedString(localizationKeys.rawValue, tableName: nil, bundle: bundle, value: localizationKeys.rawValue, comment: .empty)
    }
    
    func setLanguageType(_ languageType: LanguageType) {
        self.languageType = languageType
    }
}
