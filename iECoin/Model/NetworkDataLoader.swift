//
//  NetworkDataLoader.swift
//  iECoin
//
//  Created by Илья Валито on 16.04.2023.
//

import Foundation

// MARK: - NetworkDataLoading protocol
protocol NetworkDataLoading {

    func loadData<T: Codable>(for eCoinKey: ECoinsKeys, handler: @escaping (Result<T, Error>) -> Void)
}

// MARK: - NetworkDataLoader
struct NetworkDataLoader: NetworkDataLoading {

    private let networkClient = NetworkClient()

    func loadData<T: Codable>(for eCoinKey: ECoinsKeys, handler: @escaping (Result<T, Error>) -> Void) {
        guard let dataURL = URL(string: "https://data.messari.io/api/v1/assets/\(eCoinKey.rawValue)/metrics") else {
            preconditionFailure("Unable to create listUrl")
        }
        networkClient.fetch(url: dataURL) { result in
            do {
                let data = try result.get()
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                handler(.success(decodedData))
            } catch let error {
                handler(.failure(error))
            }
        }
    }
}
