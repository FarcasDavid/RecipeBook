//
//  CategoriesService.swift
//  RecipeBook
//
//  Created by David Farcas on 17.08.2023.
//

import Foundation

class CategoriesService: BaseURLService {

    var categoriesURL: String {
        return baseURL + "categories.php"
    }

    func fetchAllCategories() {
        NetworkManager.shared.fetchData(url: categoriesURL) { result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(RecipeMealModel.self, from: data)
                    print(json.categories)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print("Network request error: \(error)")
            }
        }
    }

}
