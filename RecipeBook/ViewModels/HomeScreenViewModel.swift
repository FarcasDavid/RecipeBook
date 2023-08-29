//
//  HomeScreenViewModel.swift
//  RecipeBook
//
//  Created by David Farcas on 14.08.2023.
//

import Foundation
import UIKit
class HomeScreenViewModel {

    private let dispatchGroup = DispatchGroup()
    private let userDefaultsName = UserDefaultsService()
    private let categoriesService = CategoriesService()
    private let mealsService = MealsService()

    var categories = [Category]()

    var userName: String {
        return userDefaultsName.getUserName()
    }

    var categoriesNumberOfItemsInSection: Int {
        return categories.count <= 5 ? categories.count : 5
    }

    var recommendationsNumberOfItemsInSection: Int {
//        return recommendations.count <= 5 ? recommendations.count : 5
        return 5
    }

    func fetchAllCategories(completion: @escaping (Bool) -> Void) {
        categoriesService.fetchAllCategories { [weak self] result in
            guard let self = self else {
                completion(false)
                return
            }

            switch result {
            case .success(let categories):
                for category in categories.categories {
                    self.dispatchGroup.enter()
                    self.downloadCategoriesImage(category.strCategoryThumb) { image in
                        self.categories.append(
                            Category(
                                id: category.idCategory,
                                title: category.strCategory,
                                image: image,
                                description: category.strCategoryDescription
                            )
                        )
                        self.dispatchGroup.leave()
                    }
                }
                self.dispatchGroup.notify(queue: .main) {
                    completion(true)
                }
            case .failure:
                completion(false)
            }
        }
    }

    func fetchMealByCategory(_ category: String, completion: @escaping(Result<Meals, Error>) -> Void) {
        mealsService.fetchMealByCategory(category, completion: completion)
    }

    private func downloadCategoriesImage(_ categoryImageURL: String, completion: @escaping(UIImage?) -> Void) {
        categoriesService.downloadCategoriesImage(categoryImageURL, completion: completion)
    }

}
