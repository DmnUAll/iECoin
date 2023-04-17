//
//  SplashScreenPresenter.swift
//  iECoin
//
//  Created by Илья Валито on 15.04.2023.
//

import UIKit

// MARK: - SplashScreenPresenter
final class SplashScreenPresenter {

    // MARK: - Properties and Initializers
    private weak var viewController: SplashScreenController?

    init(viewController: SplashScreenController? = nil) {
        self.viewController = viewController
        checkIfLoggedIn()
    }
}

// MARK: - Helpers
extension SplashScreenPresenter {

    func checkIfLoggedIn() {
        let keyWindow = UIApplication.shared.keyWindow
        let isLogged = UserDefaultsManager.shared.isUserLoggedIn
        if isLogged {
            keyWindow?.rootViewController = NavigationController(rootViewController: CoinsListScreenController())
        } else {
            keyWindow?.rootViewController = LoginScreenController()
        }
        keyWindow?.makeKeyAndVisible()
    }
}
