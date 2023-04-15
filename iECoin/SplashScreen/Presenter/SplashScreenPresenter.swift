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
        // next line was added to test the SplashScreen visability
        sleep(1)
        let isLogged = UserDefaultsManager.shared.isUserLoggedIn
        if isLogged {
            print(1)
        } else {
            UIApplication.shared.windows.first?.rootViewController = LoginScreenController()
        }
        UIApplication.shared.windows.first?.makeKeyAndVisible()
//        switch flowID {
//        case .main:
//            let nextVC = TabBarController()
//
//        case .auth:
//            let nextVC = NavigationController(rootViewController: AuthViewController())
//            UIApplication.shared.windows.first?.rootViewController = nextVC
//        }
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
