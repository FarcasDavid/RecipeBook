import Foundation
import UIKit

class HomeScreenViewModel {
    private let userDefaultsName = UserDefaultsService()
    private let categoriesService = CategoriesService()
    private let mealsService = MealsService()
    private let serialQueue = DispatchQueue(label: "serialQueue")
    private let overallGroup = DispatchGroup()
    private let mealGroup = DispatchGroup()
    private var currentCategoryIndex = 0


    var categories = [Category]()
    var recommendations = [Recommendations]()

    var userName: String {
        return userDefaultsName.getUserName()
    }

    var categoriesNumberOfItemsInSection: Int {
        return categories.count <= 5 ? categories.count : 5
    }

    var recommendationsNumberOfItemsInSection: Int {
        return recommendations.count <= 7 ? recommendations.count : 7
    }

    func fetchAllCategories(completion: @escaping (Bool) -> Void) {
        categoriesService.fetchAllCategories { [weak self] result in
            guard let self = self else {
                completion(false)
                return
            }

            switch result {
            case .success(let categories):
                self.processCategoriesSequentially(categories.categories) { success in
                    completion(success)
                }
            case .failure:
                completion(false)
            }
        }
    }

    private func processCategoriesSequentially(_ categories: [CategoryResponse], completion: @escaping (Bool) -> Void) {
        guard !categories.isEmpty else {
            completion(true)
            return
        }

        var remainingCategories = categories
        let category = remainingCategories.removeFirst()

        self.downloadImage(category.strCategoryThumb) { image in
            self.categories.append(
                Category(
                    id: category.idCategory,
                    title: category.strCategory,
                    image: image,
                    description: category.strCategoryDescription
                )
            )
            self.processCategoriesSequentially(remainingCategories) { success in
                completion(success)
            }
        }
    }

    func fetchMealByCategory(_ category: String, completion: @escaping(Result<Meals, Error>) -> Void) {
        mealsService.fetchMealByCategory(category, completion: completion)
    }

    func fetchAllMeals(completion: @escaping (Bool) -> Void) {
        guard !categories.isEmpty else {
            completion(false)
            return
        }
        func processNextCategory() {
            guard currentCategoryIndex < categories.count else {
                DispatchQueue.main.async {
                    completion(true)
                }
                return
            }

            let category = categories[currentCategoryIndex]
            serialQueue.async {
                self.overallGroup.enter()
                self.fetchMealByCategory(category.title) { [weak self] result in
                    guard let self = self else {
                        return
                    }

                    switch result {
                    case .success(let meals):
                        for meal in meals.meals {
                            self.mealGroup.enter()
                            self.downloadImage(meal.strMealThumb) { image in
                                let recommendationsModel = Recommendations(
                                    id: meal.idMeal,
                                    title: meal.strMeal,
                                    image: image,
                                    category: category.title
                                )
                                self.recommendations.append(recommendationsModel)
                                self.mealGroup.leave()
                            }
                        }
                        mealGroup.notify(queue: serialQueue) {
                            self.currentCategoryIndex += 1
                            processNextCategory()
                            self.overallGroup.leave()
                        }
                    case .failure:
                        self.overallGroup.leave()
                    }
                }
            }
        }
        processNextCategory()
    }

    private func downloadImage(_ imageURL: String, completion: @escaping(UIImage?) -> Void) {
        categoriesService.downloadImage(imageURL, completion: completion)
    }
}
