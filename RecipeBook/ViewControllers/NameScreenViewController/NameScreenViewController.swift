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

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        var launchType = UserDefaultsName()
        if !launchType.isFirstLaunch() {
            let storyboard = UIStoryboard(name: "HomeScreenViewController", bundle: nil)
            let homeScreenViewController =
            storyboard.instantiateViewController(withIdentifier: "HomeScreenViewController")
            homeScreenViewController.modalPresentationStyle = .fullScreen
            present(homeScreenViewController, animated: false)
        }
    }

}

extension NameScreenViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Save User Credentials (Name)
        let userDefaultsName = UserDefaultsName()
        if let name = nameTextField.text {
            userDefaultsName.setUserName(name)
        }

        // Perform segue to Home Screen
        let storyboard = UIStoryboard(name: "HomeScreenViewController", bundle: nil)
        let homeScreenViewController = storyboard.instantiateViewController(withIdentifier: "HomeScreenViewController")
        homeScreenViewController.modalPresentationStyle = .fullScreen
        present(homeScreenViewController, animated: true)
        return false
    }

}
