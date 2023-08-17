//
//  MealsService.swift
//  RecipeBook
//
//  Created by David Farcas on 17.08.2023.
//

import Foundation

class MealsService: BaseURLService {

   private var mealsURL: String {
        return baseURL + "filter.php?c="
    }

    func fetchMealByCategory(_ category: String, completion: @escaping (Result<Meals, Error>) -> Void) {
        NetworkManager.shared.fetchData(url: mealsURL + category) { result in
            switch result {
            case .success(let data):
                do {
                    let meals = try JSONDecoder().decode(Meals.self, from: data)
                    completion(.success(meals))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
