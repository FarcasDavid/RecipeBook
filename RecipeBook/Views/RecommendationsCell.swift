//
//  RecommendationsCell.swift
//  RecipeBook
//
//  Created by David Farcas on 25.08.2023.
//

import Foundation
import UIKit

class RecommendationsCell: UICollectionViewCell {

    @IBOutlet private weak var recommendationsImageView: UIImageView!
    @IBOutlet private weak var recommendationsTitleLabel: UILabel!
    @IBOutlet private weak var recommendationsCategoryLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    func setup(with recommendations: MealRecommendations) {
        recommendationsImageView.image = recommendations.image
        recommendationsTitleLabel.text = recommendations.title
        recommendationsCategoryLabel.text = recommendations.category
    }

    private func setup() {
        contentView.layer.cornerRadius = 16
        contentView.layer.backgroundColor = UIColor.systemBackground.cgColor
    }

}
