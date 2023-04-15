//
//  LoginScreenPresenter.swift
//  iECoin
//
//  Created by Илья Валито on 15.04.2023.
//

import UIKit

// MARK: - LoginScreenPresenter
final class LoginScreenPresenter {

    // MARK: - Properties and Initializers
    private weak var viewController: LoginScreenController?
    private let testUser = (login: "1234", password: "1234")

    init(viewController: LoginScreenController? = nil) {
        self.viewController = viewController
    }
}

// MARK: - Helpers
extension LoginScreenPresenter {
}

// MARK: - LoginScrenViewDelegate
extension LoginScreenPresenter: LoginScreenViewDelegate {

    func checkCombination(login: String, password: String) {
        guard login != "",
              password != "" else {
            viewController?.showErrorLabel()
            return
        }
        guard login == testUser.login,
              password == testUser.password else {
            viewController?.showErrorLabel()
            return
        }
        // TODO: Proceed to next screen logic needed
        print("Logged in")
    }
}
