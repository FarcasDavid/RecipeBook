//
//  RecipesModel.swift
//  RecipeBook
//
//  Created by David Farcas on 16.08.2023.
//

import Foundation

// MARK: - RecipeMealModel
struct RecipeMealModel: Codable {
    let categories: [Category]
}

// MARK: - Category
struct Category: Codable {
    let idCategory, strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
