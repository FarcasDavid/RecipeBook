//
//  NameScreenViewController.swift
//  RecipeBook
//
//  Created by David Farcas on 09.08.2023.
//

import Foundation
import UIKit

class NameScreenViewController: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!

    private var viewModel: NameScreenViewModel = NameScreenViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextField()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if viewModel.wasLaunchedBefore {
            let homeScreenViewController = HomeScreenViewController.instantiate()
            homeScreenViewController.modalPresentationStyle = .fullScreen
            present(homeScreenViewController, animated: false)
        } else if !viewModel.userName.isEmpty {
            viewModel.setWasLaunchedBefore(true)
        }
    }

}

extension NameScreenViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let name = nameTextField.text, !name.isEmpty {
            viewModel.setUserName(name)
            viewModel.setWasLaunchedBefore(true)
            let homeScreenViewController = HomeScreenViewController.instantiate()
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
        nameTextField.placeholder = LocalizedStrings.enterNamePlaceholder.rawValue.localized()
    }

    private func setupUI() {
        nameLabel.text = LocalizedStrings.whatIsYourNameLabelMessage.rawValue.localized()

    }

}
