//
//  CoinsScreenListPresenter.swift
//  iECoin
//
//  Created by Илья Валито on 16.04.2023.
//

import UIKit

// MARK: - CoinsListScreenPresenter
final class CoinsListScreenPresenter {

    // MARK: - Properties and Initializers
    private weak var viewController: CoinsListScreenController?
    private let coinDataLoader = NetworkDataLoader()
    private var eCoinsData: [UnwrappedECoin] = []

    init(viewController: CoinsListScreenController? = nil) {
        self.viewController = viewController
        loadData()
    }
}

// MARK: - Helpers
extension CoinsListScreenPresenter {

    private func convert(_ eCoinModel: ECoinModel) -> UnwrappedECoin {
        return UnwrappedECoin(name: eCoinModel.data.name,
                              shortName: eCoinModel.data.symbol,
                              price: eCoinModel.data.marketData.priceUsd ?? 0.0,
                              percentChanges: eCoinModel.data.marketData.percentChangeUsdLast24Hours ?? 0.0)
    }

    func loadData() {
        let dispatchGroup = DispatchGroup()
        ECoinsKeys.allCases.forEach { coinKey in
            dispatchGroup.enter()
            coinDataLoader.loadData(for: coinKey) { (result: Result<ECoinModel, Error>) in
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    switch result {
                    case .success(let eCoinData):
                        eCoinsData.append(convert(eCoinData))
                        dispatchGroup.leave()
                    case .failure(let error):
                        self.viewController?.showNetworkError(message: error.localizedDescription)
                    }
                }
            }
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self else { return }
            print(eCoinsData)
            print(eCoinsData.count)
            self.viewController?.showOrHideUI()
        }
    }
}
