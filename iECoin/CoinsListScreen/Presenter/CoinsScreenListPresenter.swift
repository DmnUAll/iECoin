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
    private var eCoinsManipulatedData: [UnwrappedECoin] = []
    private var sortingDirection: SortingDirections?
    private var currentFilterParameter: String = ""
    private var timer: Timer?

    init(viewController: CoinsListScreenController? = nil) {
        self.viewController = viewController
        loadData()
        // The coinData updating time can be increased if there'll be more genereous requests limit
        beginBringingUpdates(timeInterval: 120)
    }
}

// MARK: - Helpers
extension CoinsListScreenPresenter {

    @objc private func updateECoinsData() {
        print(#function)
        loadData()
    }

    private func beginBringingUpdates(timeInterval: Double) {
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: self,
                                     selector: #selector(updateECoinsData),
                                     userInfo: nil,
                                     repeats: true)
    }

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
                        if let error = error as? NetworkClient.NetworkError,
                           error == .requestsLimitError {
                            self.viewController?.showNetworkError(message: "REQUESTS_LIMIT_REACHED".localized)
                        } else {
                            self.viewController?.showNetworkError(message: error.localizedDescription)
                        }
                    }
                }
            }
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self else { return }
            eCoinsManipulatedData = eCoinsData
            filterList(byCoinName: currentFilterParameter)
            self.viewController?.showUI()
        }
    }

    func giveNumberOfRows() -> Int {
        eCoinsManipulatedData.count
    }

    func configureCell(forIndexPath indexPath: IndexPath, at tableVlew: UITableView) -> UITableViewCell {
        guard let cell = tableVlew.dequeueReusableCell(withIdentifier: K.CellsIdentifiers.coinInfo,
                                                       for: indexPath) as? CoinInfoCell else {
            return UITableViewCell()
        }
        let coin = eCoinsManipulatedData[indexPath.row]
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
            sortingDirection = .decrementByDailyPrice
            eCoinsManipulatedData.sort { $0.percentChangesUsd > $1.percentChangesUsd }
        case .incrementByDailyPrice:
            sortingDirection = .incrementByDailyPrice
            eCoinsManipulatedData.sort { $0.percentChangesUsd < $1.percentChangesUsd }
        }
        viewController?.reloadTable()
    }

    func filterList(byCoinName coinName: String) {
        currentFilterParameter = coinName
        if coinName == "" {
            eCoinsManipulatedData = eCoinsData
        } else {
            eCoinsManipulatedData = eCoinsData.filter { coin in
                coin.name.lowercased().hasPrefix(coinName.lowercased())
            }
        }
        if let sortingDirection {
            sortList(withDirection: sortingDirection)
        }
        viewController?.reloadTable()
    }
}
