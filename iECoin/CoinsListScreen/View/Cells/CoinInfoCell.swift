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
    private let stackView = UICreator.shared.makeStackView()
    let coinNameLabel = UICreator.shared.makeLabel()
    let coinPriceLabel = UICreator.shared.makeLabel()
    let coinDailyPriceLabel = UICreator.shared.makeLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        stackView.toAutolayout()
    }

    private func addSubviews() {
        stackView.addArrangedSubview(coinNameLabel)
        stackView.addArrangedSubview(coinPriceLabel)
        stackView.addArrangedSubview(coinDailyPriceLabel)
        addSubview(stackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
}
