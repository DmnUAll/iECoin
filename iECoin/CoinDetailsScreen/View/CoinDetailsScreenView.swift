//
//  CoinDetailsScreenView.swift
//  iECoin
//
//  Created by Илья Валито on 17.04.2023.
//

import UIKit

// MARK: - CoinDetailsScreenView
final class CoinDetailsScreenView: UIView {

    // MARK: - Properties and Initializers
    let coinImage = UICreator.shared.makeImageView()
    private let stackView = UICreator.shared.makeStackView(distribution: .fillEqually)
    let nameLabel = UICreator.shared.makeLabel(font: UIFont.appFont(.bold, withSize: 20))
    private let idStackView = UICreator.shared.makeStackView(axis: .horizontal, alignment: .center)
    private let idTextLabel = UICreator.shared.makeLabel(text: "\("ID".localized):")
    let idLabel = UICreator.shared.makeLabel(alignment: .right, andNumberOfLines: 1)
    private let miningAlgorithmStackView = UICreator.shared.makeStackView(axis: .horizontal, alignment: .center)
    private let miningAlgorithmTextLabel = UICreator.shared.makeLabel(text: "\("MINING_ALGORITHM".localized):",
                                                                      alignment: .left)
    let miningAlgorithmLabel = UICreator.shared.makeLabel(alignment: .right)
    private let priceTextLabel = UICreator.shared.makeLabel(text: "\("PRICE".localized):")
    private let usdPriceStackView = UICreator.shared.makeStackView(axis: .horizontal)
    let usdPriceLabel = UICreator.shared.makeLabel()
    let usdPercentLabel = UICreator.shared.makeLabel()
    private let btcPriceStackView = UICreator.shared.makeStackView(axis: .horizontal)
    let btcPriceLabel = UICreator.shared.makeLabel()
    let btcPercentLabel = UICreator.shared.makeLabel()
    private let ethPriceStackView = UICreator.shared.makeStackView(axis: .horizontal)
    let ethPriceLabel = UICreator.shared.makeLabel()
    let ethPercentLabel = UICreator.shared.makeLabel()

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
extension CoinDetailsScreenView {

    private func configureLayout() {
        toAutolayout()
        coinImage.toAutolayout()
        stackView.toAutolayout()
    }

    private func addSubviews() {
        addSubview(coinImage)
        stackView.addArrangedSubview(nameLabel)
        idStackView.addArrangedSubview(idTextLabel)
        idStackView.addArrangedSubview(idLabel)
        stackView.addArrangedSubview(idStackView)
        miningAlgorithmStackView.addArrangedSubview(miningAlgorithmTextLabel)
        miningAlgorithmStackView.addArrangedSubview(miningAlgorithmLabel)
        stackView.addArrangedSubview(miningAlgorithmStackView)
        stackView.addArrangedSubview(priceTextLabel)
        usdPriceStackView.addArrangedSubview(usdPriceLabel)
        usdPriceStackView.addArrangedSubview(usdPercentLabel)
        stackView.addArrangedSubview(usdPriceStackView)
        btcPriceStackView.addArrangedSubview(btcPriceLabel)
        btcPriceStackView.addArrangedSubview(btcPercentLabel)
        stackView.addArrangedSubview(btcPriceStackView)
        ethPriceStackView.addArrangedSubview(ethPriceLabel)
        ethPriceStackView.addArrangedSubview(ethPercentLabel)
        stackView.addArrangedSubview(ethPriceStackView)
        addSubview(stackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            coinImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.2),
            coinImage.heightAnchor.constraint(equalTo: coinImage.widthAnchor, multiplier: 1),
            coinImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            coinImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: coinImage.bottomAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
