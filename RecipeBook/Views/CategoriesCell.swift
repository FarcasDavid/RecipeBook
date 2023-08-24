//
//  CategoriesCell.swift
//  RecipeBook
//
//  Created by David Farcas on 22.08.2023.
//

import Foundation
import UIKit

class CategoriesCell: UICollectionViewCell {

    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var categoryTitleLabel: UILabel!

    static let reuseIdentifier = "CategoriesCell"

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    func setup(with category: Category) {
        categoryTitleLabel.text = category.strCategory
        categoryImageView.image = UIImage(named: category.strCategoryThumb)
    }

    private func setup() {
        contentView.layer.cornerRadius = 16
        contentView.layer.backgroundColor = UIColor.systemBackground.cgColor
    }

}
