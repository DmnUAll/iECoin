//
//  LoginScreenView.swift
//  iECoin
//
//  Created by Илья Валито on 15.04.2023.
//

// MARK: LoginScreenViewDelegate protocol
protocol LoginScreenViewDelegate: AnyObject {
    func checkCombination(login: String, password: String)
}

import UIKit

// MARK: - LoginScreenView
final class LoginScreenView: UIView {

    // MARK: - Properties and Initializers
    weak var delegate: LoginScreenViewDelegate?
    private let stackView = UICreator.shared.makeStackView(alignment: .center, addingSpacing: 16)
    let loginTextField = UICreator.shared.makeTextField(withPlacegolder: "LOGIN".localized)
    let passwordTextField = UICreator.shared.makeTextField(withPlacegolder: "PASSWORD".localized, isSecured: true)
    let errorLabel = UICreator.shared.makeLabel(text: "LOGIN_ERROR".localized, color: .iecRed)
    let loginButton = UICreator.shared.makeButton(withTitle: "LOG_IN".localized,
                                                  andAction: #selector(loginButtonTapped))

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .iecPurpleDark
        configureLayout()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension LoginScreenView {

    @objc private func loginButtonTapped() {
        delegate?.checkCombination(login: loginTextField.text ?? "", password: passwordTextField.text ?? "")
    }

    private func configureLayout() {
        toAutolayout()
        stackView.toAutolayout()
    }

    private func addSubviews() {
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(loginButton)
        addSubview(stackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 16),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            loginTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: loginTextField.heightAnchor, multiplier: 1),
            passwordTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            loginButton.heightAnchor.constraint(equalTo: loginTextField.heightAnchor, multiplier: 1),
            loginButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.5)
        ])
    }
}
