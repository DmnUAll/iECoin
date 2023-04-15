//
//  SplashScreenView.swift
//  iECoin
//
//  Created by Илья Валито on 15.04.2023.
//

import UIKit

// MARK: - SplashScreenView
final class SplashScreenView: UIView {

    // MARK: - Properties and Initializers
    private let logoImageView: UIImageView = UICreator.shared.makeImageView(withImageNamed: K.ImagesNames.splashLogo)

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
extension SplashScreenView {

    private func configureLayout() {
        toAutolayout()
        logoImageView.toAutolayout()
    }

    private func addSubviews() {
        addSubview(logoImageView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 1),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
