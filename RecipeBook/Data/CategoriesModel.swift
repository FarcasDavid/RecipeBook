//
//  RecipesModel.swift
//  RecipeBook
//
//  Created by David Farcas on 16.08.2023.
//

import Foundation
import UIKit

struct Categories: Codable {
    let categories: [CategoryResponse]
}

struct CategoryResponse: Codable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}

struct Category {
    let id: String
    let title: String
    let image: UIImage?
    let description: String
}
