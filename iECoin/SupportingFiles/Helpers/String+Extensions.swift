//
//  String+Extensions.swift
//  iECoin
//
//  Created by Илья Валито on 16.04.2023.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
