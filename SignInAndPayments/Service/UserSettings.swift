//
//  UserSettings.swift
//  SignInAndPayments
//
//  Created by Alexander Konovalov on 21.10.2021.
//

import Foundation

class UserSettings {
    
    private enum SettingsKeys: String {
        case token
    }
    
    static var token: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.token.rawValue)
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: SettingsKeys.token.rawValue)
            }
        }
    }
}
