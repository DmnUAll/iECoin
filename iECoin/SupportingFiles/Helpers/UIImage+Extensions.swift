//
//  UIImage+Extensions.swift
//  iECoin
//
//  Created by Илья Валито on 16.04.2023.
//

import UIKit

extension UIImage {

    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}
