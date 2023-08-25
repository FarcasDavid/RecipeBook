//
//  CategoriesService.swift
//  RecipeBook
//
//  Created by David Farcas on 17.08.2023.
//

import Foundation
import UIKit

class CategoriesService: BaseURLService {

    private var categoriesURL: String {
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

    func downloadCategoriesImage(_ categoryImageURL: String, completion: @escaping (UIImage?) -> Void) {
        NetworkManager.shared.fetchData(url: categoryImageURL) { [weak self] result in
            guard self != nil else {
                completion(nil)
                return
            }
            switch result {
            case .success(let data):
                completion(UIImage(data: data))
            case .failure:
                completion(nil)
            }
        }
    }

}
