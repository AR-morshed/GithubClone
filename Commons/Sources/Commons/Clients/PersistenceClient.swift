//
//  PersistenceClient.swift
//  MonstarHubSwiftUI
//
//  Created by BD Mobile Team on 8/3/22.
//

import Foundation

public struct AppPersistence {
    private static let keyForLaunch = "validateFirstLaunch"
    public static var isSignIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: keyForLaunch)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: keyForLaunch)
        }
    }
}
