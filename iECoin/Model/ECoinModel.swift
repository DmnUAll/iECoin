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
    let symbol, name: String
    let marketData: MarketData

    enum CodingKeys: String, CodingKey {
        case symbol, name
        case marketData = "market_data"
    }
}

// MARK: - MarketData
struct MarketData: Codable {
    let priceUsd, percentChangeUsdLast24Hours: Double?

    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case percentChangeUsdLast24Hours = "percent_change_usd_last_24_hours"
    }
}
