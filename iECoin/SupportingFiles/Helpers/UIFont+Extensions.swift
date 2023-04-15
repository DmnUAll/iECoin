//
//  UIFont+Extensions.swift
//  iECoin
//
//  Created by Илья Валито on 15.04.2023.
//

import UIKit

extension UIFont {

    enum AppFonts: String {
        case regular = "Unispace"
        case bold = "Unispace Bold"
    }

    static func appFont(_ style: AppFonts, withSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: style.rawValue, size: size) else {
            return UIFont.systemFont(ofSize: 8)
        }
        return font
    }
}
