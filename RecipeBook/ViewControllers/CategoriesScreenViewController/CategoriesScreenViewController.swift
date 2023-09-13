//
//  CategoriesScreenViewController.swift
//  RecipeBook
//
//  Created by David Farcas on 04.09.2023.
//

import Foundation
import UIKit

class CategoriesScreenViewController: UIViewController {

    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var categoryTitleLabel: UILabel!
    @IBOutlet private weak var categoryDescriptionTitleLabel: UILabel!
    @IBOutlet private weak var categoryDescriptionContentLabel: UILabel!
    @IBOutlet private weak var mealsTitleLabel: UILabel!
    @IBOutlet private weak var mealsTableView: UITableView!
    @IBOutlet private weak var backButton: UIButton!
    private var cellHeight: CGFloat = 140

    // Category details passed from HomeScreenVC
    var titleText: String?
    var descriptionText: String?
    var image: UIImage?

    // Meals passed from HomeScreenVC
    var meal = [MealRecommendations]()

    private var viewModel: CategoriesScreenViewModel = CategoriesScreenViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTableView()
    }

    func setupUI() {
        categoryDescriptionTitleLabel.text = LocalizedStrings.categoryDescriptionTitleLabel.rawValue.localized()
        mealsTitleLabel.text = LocalizedStrings.mealsTitleLabel.rawValue.localized()
       // view.backgroundColor = UIColor.systemGray6
        categoryImageView.image = image
        categoryTitleLabel.text = titleText
        categoryDescriptionContentLabel.appendReadmore(after: descriptionText ?? "", trailingContent: .readmore)
        backButton.setTitle(LocalizedStrings.backButton.rawValue.localized(), for: .normal)
    }

    // MARK: Actions
    @IBAction private func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction private func didTapLabel(_ sender: UITapGestureRecognizer) {
        guard let text = categoryDescriptionContentLabel.text else { return }

                let readmore = (text as NSString).range(of: TrailingContent.readmore.text)
                let readless = (text as NSString).range(of: TrailingContent.readless.text)
                if sender.didTap(label: categoryDescriptionContentLabel, inRange: readmore) {
                    categoryDescriptionContentLabel.appendReadLess(
                        after: descriptionText ?? "",
                        trailingContent: .readless
                    )
                } else if  sender.didTap(
                    label: categoryDescriptionContentLabel,
                    inRange: readless
                ) {
                    categoryDescriptionContentLabel.appendReadmore(
                        after: descriptionText ?? "",
                        trailingContent: .readmore
                    )
                } else { return }

    }

}

extension CategoriesScreenViewController: UITableViewDelegate {

    func setupTableView() {
        var totalHeight = CGFloat(meal.count) * cellHeight
        mealsTableView.dataSource = self
        mealsTableView.delegate = self
        mealsTableView.backgroundColor = .clear
        let nib = UINib(nibName: "MealsCell", bundle: nil)
        mealsTableView.register(nib, forCellReuseIdentifier: "MealsCell")
        mealsTableView.layer.cornerRadius = 16
        mealsTableView.isScrollEnabled = false
        let heightConstraint = NSLayoutConstraint(
            item: mealsTableView as Any,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: totalHeight
        )
        heightConstraint.isActive = true
    }

}

extension CategoriesScreenViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meal.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MealsCell = mealsTableView.dequeue(for: indexPath)
        cell.setup(with: meal[indexPath.row])
         return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

}
