//
//  LoginScreenController.swift
//  iECoin
//
//  Created by Илья Валито on 15.04.2023.
//

import UIKit

// MARK: - LoginScreenController
final class LoginScreenController: UIViewController {

    // MARK: - Properties and Initializers
    private let loginScreenView = LoginScreenView()
    private var presenter: LoginScreenPresenter?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addKeyboardHiddingFeature()
        addSubviews()
        setupConstraints()
        presenter = LoginScreenPresenter(viewController: self)
        loginScreenView.delegate = presenter
        loginScreenView.loginTextField.delegate = self
        loginScreenView.passwordTextField.delegate = self
        loginScreenView.errorLabel.isHidden = true
    }
}

// MARK: - Helpers
extension LoginScreenController {

    private func addSubviews() {
        view.addSubview(loginScreenView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loginScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginScreenView.topAnchor.constraint(equalTo: view.topAnchor),
            loginScreenView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginScreenView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func showErrorLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.loginScreenView.errorLabel.isHidden = false
        }
    }
}

// MARK: - UITextFieldDelegate
extension LoginScreenController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.loginScreenView.errorLabel.isHidden = true
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !textField.isSecureTextEntry {
            loginScreenView.passwordTextField.becomeFirstResponder()
        } else {
            loginScreenView.loginButton.sendActions(for: .touchUpInside)
            view.endEditing(true)
        }
        return true
    }
}
