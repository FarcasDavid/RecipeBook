//
//  UserDefaultsName.swift
//  RecipeBook
//
//  Created by David Farcas on 10.08.2023.
//
import Foundation


class UserDefaultsService {

    private let userDefaults = UserDefaults.standard

    func setUserName(_ name: String) {
        userDefaults.set(name, forKey: UserDefaultsKeys.username.rawValue)
    }

    func getUserName() -> String? {
        let username = userDefaults.string(forKey: UserDefaultsKeys.username.rawValue)
        return username ?? ""
    }

    func setWasLaunchedBefore(_ launchType: Bool) {
        userDefaults.set(launchType, forKey: UserDefaultsKeys.wasLaunchedBefore.rawValue)
    }

    func getWasLaunchedBefore() -> Bool {
        let wasLaunchedBefore = userDefaults.bool(forKey: UserDefaultsKeys.wasLaunchedBefore.rawValue)
        return wasLaunchedBefore
    }

}

enum UserDefaultsKeys: String {
    case username
    case wasLaunchedBefore
}
