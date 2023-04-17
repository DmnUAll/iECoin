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
        UnwrappedECoin(id: eCoinModel.data.id,
                       name: eCoinModel.data.name,
                       shortName: eCoinModel.data.symbol,
                       miningAlgorithm: eCoinModel.data.miningStats.miningAlgo ?? "NO_DATA".localized,
                       priceUsd: eCoinModel.data.marketData.priceUsd ?? 0.0,
                       priceBtc: eCoinModel.data.marketData.priceBtc ?? 0.0,
                       priceEth: eCoinModel.data.marketData.priceEth ?? 0.0,
                       percentChangesUsd: eCoinModel.data.marketData.percentChangeUsdLast24Hours ?? 0.0,
                       percentChangesBtc: eCoinModel.data.marketData.percentChangeBtcLast24Hours ?? 0.0,
                       percentChangesEth: eCoinModel.data.marketData.percentChangeEthLast24Hours ?? 0.0)
    }

    func loadData() {
        eCoinsData = []
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
            self.viewController?.showOrHideUI()
        }
    }

    func giveNumberOfRows() -> Int {
        eCoinsData.count
    }

    func configureCell(forIndexPath indexPath: IndexPath, at tableVlew: UITableView) -> UITableViewCell {
        guard let cell = tableVlew.dequeueReusableCell(withIdentifier: K.CellsIdentifiers.coinInfo,
                                                       for: indexPath) as? CoinInfoCell else {
            return UITableViewCell()
        }
        let coin = eCoinsData[indexPath.row]
        let noData = coin.priceUsd == 0.0
        cell.coinImage.image = UIImage(named: coin.name.lowercased())
        cell.coinNameLabel.text = "\(coin.shortName) (\(coin.name))"
        cell.coinPriceLabel.text = noData ? "NO_DATA".localized : "\(coin.priceUsd.shortDouble()) $"
        cell.coinDailyPriceLabel.text = noData ? "NO_DATA".localized : "(\(coin.percentChangesUsd.shortDouble()) %)"
        if coin.percentChangesUsd > 0 {
            cell.coinDailyPriceLabel.textColor = .iecGreen
        } else if coin.percentChangesUsd < 0 {
            cell.coinDailyPriceLabel.textColor = .iecRed
        } else {
            cell.coinDailyPriceLabel.textColor = .iecCream
        }
        return cell
    }

    func giveData(for indexPath: IndexPath) -> UnwrappedECoin {
        eCoinsData[indexPath.row]
    }

    func sortList(withDirection direction: SortingDirections) {
        switch direction {
        case .decrementByDailyPrice:
            eCoinsData.sort { $0.percentChangesUsd > $1.percentChangesUsd }
        case .incrementByDailyPrice:
            eCoinsData.sort { $0.percentChangesUsd < $1.percentChangesUsd }
        }
    }
}
