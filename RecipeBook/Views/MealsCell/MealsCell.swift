//
//  MealsCell.swift
//  RecipeBook
//
//  Created by David Farcas on 11.09.2023.
//

import UIKit
class MealsCell: UITableViewCell {
    @IBOutlet private weak var mealImageView: UIImageView!
    @IBOutlet private weak var mealTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }

    private func setup() {
        contentView.backgroundColor = .systemGray6
        mealImageView.layer.cornerRadius = 16
    }

    func setup(with meal: MealRecommendations) {
        mealImageView.image = meal.image
        mealTitleLabel.text = meal.title
    }

}
