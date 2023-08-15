//
//  String+Localized.swift
//  RecipeBook
//
//  Created by David Farcas on 15.08.2023.
//

import Foundation

extension String {

    public func localized(comment: String = "") -> String {
        NSLocalizedString(self, comment: comment)
    }

}
