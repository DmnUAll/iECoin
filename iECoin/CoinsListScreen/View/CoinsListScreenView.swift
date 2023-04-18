//
//  CoinsListScreenView.swift
//  iECoin
//
//  Created by Илья Валито on 16.04.2023.
//

import UIKit

// MARK: - CoinsListScreenView
final class CoinsListScreenView: UIView {

    // MARK: - Properties and Initializers
    let activityIndicator = UICreator.shared.makeActivityIndicator(withColor: .iecCream)
    let searchTextField = UICreator.shared.makeSearchTextField()
    let tableView = UICreator.shared.makeTable(withCells: (type: CoinInfoCell.self,
                                                           identifier: K.CellsIdentifiers.coinInfo))

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
extension CoinsListScreenView {

    private func configureLayout() {
        toAutolayout()
        activityIndicator.toAutolayout()
        searchTextField.toAutolayout()
        tableView.toAutolayout()
    }

    private func addSubviews() {
        addSubview(activityIndicator)
        addSubview(searchTextField)
        addSubview(tableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 4),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
