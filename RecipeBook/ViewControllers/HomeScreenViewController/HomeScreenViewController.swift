//
//  HomeScreenViewController.swift
//  RecipeBook
//
//  Created by David Farcas on 10.08.2023.
//

import UIKit
import Foundation

class HomeScreenViewController: UIViewController {

    @IBOutlet private weak var welcomeUserLabel: UILabel!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var titleMainScreenLabel: UILabel!
    @IBOutlet private weak var categoriesCollectionView: UICollectionView!
    @IBOutlet private weak var categoriesTitleLabel: UILabel!
    @IBOutlet private weak var seeAllCategoriesButton: UIButton!
    @IBOutlet private weak var recommendationsCollectionView: UICollectionView!
    @IBOutlet private weak var seeAllRecommendationsButton: UIButton!
    @IBOutlet private weak var recommendationsTitleLabel: UILabel!


    private var categoriesCellSize = CGSize(width: 90, height: 90)
    private var recommendationsCellSize = CGSize(width: 150, height: 250)
    private var viewModel: HomeScreenViewModel = HomeScreenViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchButton()
        setupUI()
        setupCategoriesCollectionView()
        setupRecommendationsCollectionView()
        loadAllData()

    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            categoriesCollectionView.reloadData()
            recommendationsCollectionView.reloadData()
        }
    }

}

// MARK: UISetup
extension HomeScreenViewController {

    private func setupSearchButton() {
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = UIColor.black.cgColor
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
    }

    private func setupUI() {
        welcomeUserLabel.text = String(format: LocalizedStrings.helloMessage.rawValue.localized(), viewModel.userName)
        titleMainScreenLabel.text = LocalizedStrings.descriptionCookingMessage.rawValue.localized()
        categoriesTitleLabel.text = LocalizedStrings.categoriesTitleLabel.rawValue.localized()
        seeAllCategoriesButton.setTitle(LocalizedStrings.seeAllButton.rawValue.localized(), for: .normal)
        recommendationsTitleLabel.text = LocalizedStrings.recommendationsTitleLabel.rawValue.localized()
        seeAllRecommendationsButton.setTitle(LocalizedStrings.seeAllButton.rawValue.localized(), for: .normal)

        view.backgroundColor = UIColor.systemGray6
    }

}

// MARK: Actions
extension HomeScreenViewController {

    @IBAction private func searchButtonTapped(_ sender: UIButton) {
    }

}

// MARK: Methods
extension HomeScreenViewController {

    func loadAllData() {
        viewModel.fetchAllCategories { isLoaded in
            if isLoaded {
                DispatchQueue.main.async {
                    self.categoriesCollectionView.reloadData()
                }
                self.viewModel.fetchAllMeals { isLoaded in
                    if isLoaded {
                        DispatchQueue.main.async {
                            self.recommendationsCollectionView.reloadData()
                        }
                    }
                }
            }
        }
    }

}

// MARK: Categories Collection View
extension HomeScreenViewController {

    func setupCategoriesCollectionView() {
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.backgroundColor = .clear
        categoriesCollectionView.showsHorizontalScrollIndicator = false
        categoriesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        if let layout = categoriesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 16
            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }

}

// MARK: Recommendation Collection View
extension HomeScreenViewController {

    func setupRecommendationsCollectionView() {
        recommendationsCollectionView.delegate = self
        recommendationsCollectionView.dataSource = self
        recommendationsCollectionView.backgroundColor = .clear
        recommendationsCollectionView.showsHorizontalScrollIndicator = false
        recommendationsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        if let layout = recommendationsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 16
            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
}

extension HomeScreenViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            if collectionView == categoriesCollectionView {
                return viewModel.categoriesNumberOfItemsInSection
            }
            if collectionView == recommendationsCollectionView {
                return viewModel.recommendationsNumberOfItemsInSection
            }
            return 0
        }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            let cell: CategoriesCell = categoriesCollectionView.dequeue(for: indexPath)
            let category = viewModel.categories[indexPath.row]
            cell.setup(with: category)
            return cell
        }
        if collectionView == recommendationsCollectionView {
            let cell: RecommendationsCell = recommendationsCollectionView.dequeue(for: indexPath)
            let meal = viewModel.recommendations[indexPath.row]
            cell.setup(with: meal)
            return cell
        }
        return UICollectionViewCell()
    }

}

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            if collectionView == categoriesCollectionView {
                return categoriesCellSize
            }
            if collectionView == recommendationsCollectionView {
                return recommendationsCellSize
            }
            return CGSize()
        }

}

extension HomeScreenViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesCollectionView {
            jumpToCategoryDetails()
        }
    }

    func jumpToCategoryDetails() {
        performSegue(withIdentifier: "goToCategoriesScreen", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCategoriesScreen" {
            if let selectedIndexPath = categoriesCollectionView.indexPathsForSelectedItems?.first,
               let categoriesScreenViewController = segue.destination as? CategoriesScreenViewController {
                categoriesScreenViewController.modalPresentationStyle = .fullScreen
                let selectedCategory = viewModel.categories[selectedIndexPath.row]
                categoriesScreenViewController.titleText = selectedCategory.title
                categoriesScreenViewController.descriptionText = selectedCategory.description
                categoriesScreenViewController.image = selectedCategory.image
                for meal in viewModel.recommendations where meal.category == selectedCategory.title {
                    categoriesScreenViewController.meal.append(meal)
                }
            }
        }
    }


}
