//
//  MealsService.swift
//  RecipeBook
//
//  Created by David Farcas on 17.08.2023.
//

import Foundation

class MealsService: BaseURLService {

    var mealsURL: String {
        return baseURL + "filter.php?c="
    }

    func fetchMealByCategory() {
        NetworkManager.shared.fetchData(url: mealsURL) { result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(MealsModel.self, from: data)
                    print(json.meals)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print("Network request error: \(error)")
            }
        }
    }

}
