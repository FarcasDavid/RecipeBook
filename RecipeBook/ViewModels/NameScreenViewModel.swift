//
//  NameScreenViewModel.swift
//  RecipeBook
//
//  Created by David Farcas on 14.08.2023.
//

import Foundation

class NameScreenViewModel {

    let userDefaultsProperty = UserDefaultsService()

    func updateUserName(_ name: String) {
        userDefaultsProperty.setUserName(name)
    }

    var wasLaunchedBefore: Bool {
        if userDefaultsProperty.getWasLaunchedBefore() {
            return true
        } else {
            return false
        }
    }

}
