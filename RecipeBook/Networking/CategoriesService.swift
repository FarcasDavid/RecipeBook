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

    func fetchAllCategories(completion: @escaping (Result<Categories, Error>) -> Void) {
        NetworkManager.shared.fetchData(url: categoriesURL) { result in
            switch result {
            case .success(let data):
                do {
                    let categories = try JSONDecoder().decode(Categories.self, from: data)
                    completion(.success(categories))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
