//
//  UserDefaultsName.swift
//  RecipeBook
//
//  Created by David Farcas on 10.08.2023.
//

import Foundation


class UserDefaultsName {

    let userDefaults = UserDefaults.standard


    func setUserName(_ name: String) {
        userDefaults.set(name, forKey: Keys.username.rawValue)

    }

    func getUserName() -> String? {
        let username = userDefaults.string(forKey: Keys.username.rawValue)
        return username ?? ""
    }

    // Check first launch
    func isFirstLaunch() -> Bool {
        // Check if this is the first launch
        var isFirstLaunch =
        UserDefaults.standard.bool(forKey: Keys.isFirstLaunch.rawValue) // false by default
        let wasLaunchedBefore = UserDefaults.standard.bool(forKey: Keys.wasLaunchedBefore.rawValue)
        isFirstLaunch = !wasLaunchedBefore // set isFirstLaunch to true on first launch
        if isFirstLaunch {
            UserDefaults.standard.set(false, forKey: Keys.isFirstLaunch.rawValue)
            UserDefaults.standard.set(true, forKey: Keys.wasLaunchedBefore.rawValue)
            return true
        } else {
            return false
        }
    }

    enum Keys: String {
        case username
        case isFirstLaunch
        case wasLaunchedBefore
    }

}
