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
        hideUI()
        presenter = CoinsListScreenPresenter(viewController: self)
        coinsListScreenView.searchTextField.delegate = self
        coinsListScreenView.tableView.dataSource = self
        coinsListScreenView.tableView.delegate = self
        (navigationController as? NavigationController)?.sortingDelegate = self
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

    func hideUI() {
        coinsListScreenView.activityIndicator.startAnimating()
        coinsListScreenView.tableView.isHidden = true
    }

    func showUI() {
        coinsListScreenView.activityIndicator.stopAnimating()
        reloadTable()
        coinsListScreenView.tableView.isHidden = false
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

    func reloadTable() {
        coinsListScreenView.tableView.reloadData()
    }
}

// MARK: - UISearchTextFieldDelegate
extension CoinsListScreenController: UISearchTextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String
    ) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        presenter?.filterList(byCoinName: updatedText)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

// MARK: - UITableViewDataSource
extension CoinsListScreenController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.giveNumberOfRows() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter?.configureCell(forIndexPath: indexPath, at: tableView) ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension CoinsListScreenController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let coinData = presenter?.giveData(for: indexPath) else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        let nextVC = CoinDetailsScreenController(coinData: coinData)
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - SortingDelegate
extension CoinsListScreenController: SortingDelegate {

    func sortItems(using sortingDirection: SortingDirections) {
        presenter?.sortList(withDirection: sortingDirection)
    }
}
