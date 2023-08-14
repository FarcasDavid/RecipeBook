//
//  NameScreenViewModel.swift
//  RecipeBook
//
//  Created by David Farcas on 14.08.2023.
//

import Foundation

class NameScreenViewModel {

    let userDefaultsProperty = UserDefaultsService()

    var wasLaunchedBefore: Bool {
        return userDefaultsProperty.getWasLaunchedBefore()
    }

    func setUserName(_ name: String) {
        userDefaultsProperty.setUserName(name)
    }

}
