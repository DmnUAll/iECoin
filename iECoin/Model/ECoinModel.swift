//
//  ECoinModel.swift
//  iECoin
//
//  Created by Илья Валито on 16.04.2023.
//

import Foundation

// MARK: - ECoinModel
struct ECoinModel: Codable {

    let data: ECoinData
}

// MARK: - ECoinData
struct ECoinData: Codable {

    let id, symbol, name: String
    let marketData: MarketData
    let miningStats: MiningStats

    enum CodingKeys: String, CodingKey {

        case id, symbol, name
        case marketData = "market_data"
        case miningStats = "mining_stats"
    }
}

// MARK: - MarketData
struct MarketData: Codable {

    let priceUsd, priceBtc, priceEth: Double?
    let percentChangeUsdLast24Hours, percentChangeBtcLast24Hours, percentChangeEthLast24Hours: Double?

    enum CodingKeys: String, CodingKey {

        case priceUsd = "price_usd"
        case priceBtc = "price_btc"
        case priceEth = "price_eth"
        case percentChangeUsdLast24Hours = "percent_change_usd_last_24_hours"
        case percentChangeBtcLast24Hours = "percent_change_btc_last_24_hours"
        case percentChangeEthLast24Hours = "percent_change_eth_last_24_hours"
    }
}

// MARK: - MiningStats
struct MiningStats: Codable {

    let miningAlgo: String?

    enum CodingKeys: String, CodingKey {

        case miningAlgo = "mining_algo"
    }
}
