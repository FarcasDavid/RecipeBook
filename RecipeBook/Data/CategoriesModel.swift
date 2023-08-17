//
//  RecipesModel.swift
//  RecipeBook
//
//  Created by David Farcas on 16.08.2023.
//

import Foundation

struct Categories: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
