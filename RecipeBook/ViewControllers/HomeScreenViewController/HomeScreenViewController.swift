//
//  HomeScreenViewController.swift
//  RecipeBook
//
//  Created by David Farcas on 10.08.2023.
//

import UIKit
import Foundation

class HomeScreenViewController: UIViewController {

    // IBOutlets:
    @IBOutlet private weak var welcomeUserLabel: UILabel!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var titleMainScreenLabel: UILabel!

    // ViewModel:
    var viewModel: HomeScreenViewModel = HomeScreenViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchButton()
        setupUI()

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
        welcomeUserLabel.text = "Hello, \(viewModel.userName)"
    }

}

// MARK: Actions

extension HomeScreenViewController {

    @IBAction private func searchButtonTapped(_ sender: UIButton) {
    }

}
