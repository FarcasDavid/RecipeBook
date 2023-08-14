//
//  NameScreenViewModel.swift
//  RecipeBook
//
//  Created by David Farcas on 14.08.2023.
//

import Foundation

class NameScreenViewModel {

    private let userDefaultsProperty = UserDefaultsService()

    var wasLaunchedBefore: Bool {
        return userDefaultsProperty.getWasLaunchedBefore()
    }

    var userName: String {
        return userDefaultsProperty.getUserName()
    }

    func setWasLaunchedBefore(_ launchType: Bool) {
        userDefaultsProperty.setWasLaunchedBefore(launchType)
    }

    func setUserName(_ name: String) {
        userDefaultsProperty.setUserName(name)
    }

}
