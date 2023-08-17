//
//  HomeScreenViewModel.swift
//  RecipeBook
//
//  Created by David Farcas on 14.08.2023.
//

import Foundation

class HomeScreenViewModel {

    private let userDefaultsName = UserDefaultsService()
    private let categoriesService = CategoriesService()
    private let mealsService = MealsService()

    var userName: String {
        return userDefaultsName.getUserName()
    }

    func fetchAllCategories(completion: @escaping(Result<Categories, Error>) -> Void) {
        categoriesService.fetchAllCategories(completion: completion)
    }

    func fetchMealByCategory(_ category: String, completion: @escaping(Result<Meals, Error>) -> Void) {
        mealsService.fetchMealByCategory(category, completion: completion)
    }

}
