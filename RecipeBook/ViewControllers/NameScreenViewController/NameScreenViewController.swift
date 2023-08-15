//
//  NameScreenViewController.swift
//  RecipeBook
//
//  Created by David Farcas on 09.08.2023.
//

import Foundation
import UIKit

class NameScreenViewController: UIViewController {

    // IBOutlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!

    // View Model
    private var viewModel: NameScreenViewModel = NameScreenViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextField()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        if viewModel.wasLaunchedBefore {
            let storyboard = UIStoryboard(name: "HomeScreenViewController", bundle: nil)
            let homeScreenViewController =
            storyboard.instantiateViewController(withIdentifier: "HomeScreenViewController")
            homeScreenViewController.modalPresentationStyle = .fullScreen
            present(homeScreenViewController, animated: false)
        } else if !viewModel.userName.isEmpty {
            viewModel.setWasLaunchedBefore(true)
        }
    }

}

extension NameScreenViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Update User Credentials (Name)
        if let name = nameTextField.text, !name.isEmpty {
            viewModel.setUserName(name)
            viewModel.setWasLaunchedBefore(true)

            // Perform segue to Home Screen
            let storyboard = UIStoryboard(name: "HomeScreenViewController", bundle: nil)
            let homeScreenViewController =
            storyboard.instantiateViewController(withIdentifier: "HomeScreenViewController")
            homeScreenViewController.modalPresentationStyle = .fullScreen
            present(homeScreenViewController, animated: true)
        }
        return true
    }

}

// MARK: Setup
extension NameScreenViewController {

    private func setupTextField() {
        nameTextField.delegate = self
        nameTextField.textAlignment = .center
        nameTextField.placeholder = NSLocalizedString("Enter your name here", comment: "")
    }

    private func setupUI() {
        nameLabel.text = NSLocalizedString("What is your name?", comment: "")

    }

}
