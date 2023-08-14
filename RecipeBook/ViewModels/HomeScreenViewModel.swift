//
//  HomeScreenViewModel.swift
//  RecipeBook
//
//  Created by David Farcas on 14.08.2023.
//

import Foundation

class HomeScreenViewModel {

    let userDefaultsName = UserDefaultsService()

    func getUserName() -> String {
        return userDefaultsName.getUserName() ?? ""
    }

}
