//
//  CoinsListScreenController.swift
//  iECoin
//
//  Created by Илья Валито on 16.04.2023.
//

import UIKit

// MARK: - CoinsListScreenController
final class CoinsListScreenController: UIViewController {

    // MARK: - Properties and Initializers
    private let coinsListScreenView = CoinsListScreenView()
    private var presenter: CoinsListScreenPresenter?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addKeyboardHiddingFeature()
        title = "COINS_LIST".localized
        addSubviews()
        setupConstraints()
        showOrHideUI()
        presenter = CoinsListScreenPresenter(viewController: self)
    }
}

// MARK: - Helpers
extension CoinsListScreenController {

    private func addSubviews() {
        view.addSubview(coinsListScreenView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            coinsListScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coinsListScreenView.topAnchor.constraint(equalTo: view.topAnchor),
            coinsListScreenView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coinsListScreenView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func showOrHideUI() {
        if coinsListScreenView.activityIndicator.isAnimating {
            coinsListScreenView.activityIndicator.stopAnimating()
            coinsListScreenView.tableView.isHidden = false
        } else {
            coinsListScreenView.activityIndicator.startAnimating()
            coinsListScreenView.tableView.isHidden = true
        }
    }

    func showNetworkError(message: String) {
        let alertModel = UIAlertController(title: "NETWORK_ERROR".localized,
                                           message: message,
                                           preferredStyle: .alert)
        let tryAgainAction = UIAlertAction(title: "TRY_AGAIN".localized,
                                           style: .cancel) { [weak self] _ in
            guard let self = self else { return }
            self.presenter?.loadData()
        }
        alertModel.addAction(tryAgainAction)
        present(alertModel, animated: true)
    }
}

// MARK: - UITableViewDataSource

// MARK: - UITableViewDelegate
