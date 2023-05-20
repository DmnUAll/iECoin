//
//  NetworkClient.swift
//  iECoin
//
//  Created by Илья Валито on 16.04.2023.
//

import Foundation

// MARK: - NetworkClient
struct NetworkClient {

    enum NetworkError: Error {

        case codeError
        case requestsLimitError
    }

    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(error))
                return
            }
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                if response.statusCode == 429 {
                    handler(.failure(NetworkError.requestsLimitError))
                } else {
                    handler(.failure(NetworkError.codeError))
                }
                return
            }
            guard let data = data else { return }
            handler(.success(data))
        }
        task.resume()
    }
}
