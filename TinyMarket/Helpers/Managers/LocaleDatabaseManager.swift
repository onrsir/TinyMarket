//
//  LocaleDatabaseManager.swift
//  TinyMarket
//
//  Created by Onur Sır on 07.04.2023.
//

import Foundation

final class LocaleDatabaseManager {
    
    static let shared = LocaleDatabaseManager()
    
    private init() { }
    
    func setLanguageType(_ languageType: LanguageType) {
        let data = try? JSONEncoder().encode(languageType)
        UserDefaults.standard.set(data, forKey: Keys.languageType.rawValue)
    }
    
    func getLanguageType() -> LanguageType? {
        guard let data = UserDefaults.standard.object(forKey: Keys.languageType.rawValue) as? Data else { return nil }
        return try? JSONDecoder().decode(LanguageType.self, from: data)
    }
}

// MARK: - UserDefaults Keys
private extension LocaleDatabaseManager {
    
    enum Keys: String {
        case languageType
    }
}
