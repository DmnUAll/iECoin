//
//  SplashScreenController.swift
//  iECoin
//
//  Created by Илья Валито on 15.04.2023.
//

import UIKit

// MARK: - SplashScreenController
final class SplashScreenController: UIViewController {

    // MARK: - Properties and Initializers
    private let splashScreenView = SplashScreenView()
    private var presenter: SplashScreenPresenter?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter = SplashScreenPresenter(viewController: self)
    }
}

// MARK: - Helpers
extension SplashScreenController {

    private func addSubviews() {
        view.addSubview(splashScreenView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            splashScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            splashScreenView.topAnchor.constraint(equalTo: view.topAnchor),
            splashScreenView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            splashScreenView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
