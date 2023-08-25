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

    private var categoriesCellSize = CGSize(width: 90, height: 90)
    private var viewModel: HomeScreenViewModel = HomeScreenViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchButton()
        setupUI()
        setupCategoriesCollectionView()
        loadAllCategories()
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
        categoriesTitleLabel.text = LocalizedStrings.categories.rawValue.localized()
        seeAllCategoriesButton.setTitle(LocalizedStrings.seeAll.rawValue.localized(), for: .normal)

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
    func loadAllCategories() {
        viewModel.fetchAllCategories { isLoaded in
            if isLoaded {
                DispatchQueue.main.async {
                    self.categoriesCollectionView.reloadData()
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

extension HomeScreenViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =
                categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath)
                as? CategoriesCell
        else {
            return UICollectionViewCell()
        }

        let category = viewModel.categories[indexPath.row]
        cell.setup(with: category)
        return cell
    }

}

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            return categoriesCellSize
        }

}
