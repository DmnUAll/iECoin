//
//  Double+Extensions.swift
//  iECoin
//
//  Created by Илья Валито on 17.04.2023.
//

import Foundation

extension Double {
    func shortDouble(to numberOfDigits: Int = 2) -> String {
        String(format: "%.\(numberOfDigits)f", self)
    }
}
