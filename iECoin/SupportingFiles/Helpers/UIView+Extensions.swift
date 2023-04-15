//
//  UIView+Extensions.swift
//  iECoin
//
//  Created by Илья Валито on 15.04.2023.
//

import UIKit

extension UIView {

    func toAutolayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func addKeyboardHiddingFeature() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
}
