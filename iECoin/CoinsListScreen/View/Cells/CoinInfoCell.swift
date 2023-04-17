//
//  CoinInfoCell.swift
//  iECoin
//
//  Created by Илья Валито on 16.04.2023.
//

import UIKit

// MARK: - CoinInfoCell
final class CoinInfoCell: UITableViewCell {

    // MARK: - Properties and Initializers
    let coinImage = UICreator.shared.makeImageView()
    private let stackView = UICreator.shared.makeStackView(addingSpacing: 8)
    let coinNameLabel = UICreator.shared.makeLabel(font: UIFont.appFont(.bold, withSize: 12), alignment: .left)
    private let priceStackView = UICreator.shared.makeStackView(axis: .horizontal, distribution: .fillEqually)
    let coinPriceLabel = UICreator.shared.makeLabel(alignment: .left)
    let coinDailyPriceLabel = UICreator.shared.makeLabel(alignment: .right)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .iecPurple
        layer.cornerRadius = 14
        layer.masksToBounds = true
        layer.borderColor = UIColor.iecPurpleDark.cgColor
        layer.borderWidth = 2
        configureLayout()
        addSubviews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Helpers
extension CoinInfoCell {

    private func configureLayout() {
        coinImage.toAutolayout()
        stackView.toAutolayout()
    }

    private func addSubviews() {
        stackView.addArrangedSubview(coinNameLabel)
        priceStackView.addArrangedSubview(coinPriceLabel)
        priceStackView.addArrangedSubview(coinDailyPriceLabel)
        stackView.addArrangedSubview(priceStackView)
        addSubview(coinImage)
        addSubview(stackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            coinImage.heightAnchor.constraint(equalToConstant: 60),
            coinImage.widthAnchor.constraint(equalTo: coinImage.heightAnchor, multiplier: 1),
            coinImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            coinImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            coinImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            stackView.centerYAnchor.constraint(equalTo: coinImage.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: coinImage.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
