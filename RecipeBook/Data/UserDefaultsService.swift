//
//  UserDefaultsName.swift
//  RecipeBook
//
//  Created by David Farcas on 10.08.2023.
//
import Foundation


class UserDefaultsService {

    let userDefaults = UserDefaults.standard

    func setUserName(_ name: String) {
        userDefaults.set(name, forKey: UserDefaultsKeys.username.rawValue)
    }

    func getUserName() -> String? {
        let username = userDefaults.string(forKey: UserDefaultsKeys.username.rawValue)
        return username ?? ""
    }

    // Check first launch
    func isFirstLaunch() -> Bool {
        // Check if this is the first launch
        var isFirstLaunch =
        UserDefaults.standard.bool(forKey: UserDefaultsKeys.isFirstLaunch.rawValue) // false by default
        let wasLaunchedBefore = UserDefaults.standard.bool(forKey: UserDefaultsKeys.wasLaunchedBefore.rawValue)
        isFirstLaunch = !wasLaunchedBefore // set isFirstLaunch to true on first launch
        if isFirstLaunch {
            UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isFirstLaunch.rawValue)
            UserDefaults.standard.set(true, forKey: UserDefaultsKeys.wasLaunchedBefore.rawValue)
            return true
        } else {
            return false
        }
    }

}

enum UserDefaultsKeys: String {
    case username
    case isFirstLaunch
    case wasLaunchedBefore
}
