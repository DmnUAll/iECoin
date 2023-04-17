//
//  CoinDetailsScreenController.swift
//  iECoin
//
//  Created by Илья Валито on 17.04.2023.
//

import UIKit

// MARK: - CoinDetailsScreenController
final class CoinDetailsScreenController: UIViewController {

    // MARK: - Properties and Initializers
    private let coinDetailsScreenView = CoinDetailsScreenView()
    private var presenter: CoinDetailsScreenPresenter?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    convenience init(coinData: UnwrappedECoin) {
        self.init()
        fillUI(withData: coinData)
        title = "\("DETAILS".localized) \(coinData.shortName)"
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        presenter = CoinDetailsScreenPresenter(viewController: self)
    }
}

// MARK: - Helpers
extension CoinDetailsScreenController {

    private func addSubviews() {
        view.addSubview(coinDetailsScreenView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            coinDetailsScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coinDetailsScreenView.topAnchor.constraint(equalTo: view.topAnchor),
            coinDetailsScreenView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coinDetailsScreenView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fillUI(withData coinData: UnwrappedECoin) {

        coinDetailsScreenView.coinImage.image = UIImage(named: coinData.name.lowercased())
        coinDetailsScreenView.nameLabel.text = "\(coinData.name)\n(\(coinData.shortName))"
        coinDetailsScreenView.idLabel.text = coinData.id
        coinDetailsScreenView.miningAlgorithmLabel.text = coinData.miningAlgorithm
        coinDetailsScreenView.usdPriceLabel.text = "\(coinData.priceUsd.shortDouble(to: 6)) $"
        coinDetailsScreenView.usdPercentLabel.text = "\(coinData.percentChangesUsd.shortDouble()) %"
        coinDetailsScreenView.btcPriceLabel.text = "\(coinData.priceBtc.shortDouble(to: 6)) BTC"
        coinDetailsScreenView.btcPercentLabel.text = "\(coinData.percentChangesBtc.shortDouble()) %"
        coinDetailsScreenView.ethPriceLabel.text = "\(coinData.priceEth.shortDouble(to: 6)) ETH"
        coinDetailsScreenView.ethPercentLabel.text = "\(coinData.percentChangesEth.shortDouble()) %"
        changeTextColor(basedOnData: coinData.percentChangesUsd,
                        forLabels: [
                            coinDetailsScreenView.usdPriceLabel,
                            coinDetailsScreenView.usdPercentLabel
                        ])
        changeTextColor(basedOnData: coinData.percentChangesBtc,
                        forLabels: [
                            coinDetailsScreenView.btcPriceLabel,
                            coinDetailsScreenView.btcPercentLabel
                        ])
        changeTextColor(basedOnData: coinData.percentChangesEth,
                        forLabels: [
                            coinDetailsScreenView.ethPriceLabel,
                            coinDetailsScreenView.ethPercentLabel
                        ])
    }

    private func changeTextColor(basedOnData data: Double, forLabels labels: [UILabel]) {
        if data > 0.0 {
            labels.forEach { label in
                label.textColor = .iecGreen
            }
        } else if data < 0.0 {
            labels.forEach { label in
                label.textColor = .iecRed
            }
        }
    }
}
