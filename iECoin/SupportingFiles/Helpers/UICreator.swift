//
//  UICreator.swift
//  iECoin
//
//  Created by Илья Валито on 15.04.2023.
//

import UIKit

// MARK: - UICreator
struct UICreator {

    static let shared = UICreator()

    func makeLabel(text: String? = nil,
                   font: UIFont = UIFont.appFont(.regular, withSize: 12),
                   color: UIColor = .iecCream,
                   alignment: NSTextAlignment = .center,
                   andNumberOfLines numberOfLines: Int = 0
    ) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        label.textAlignment = alignment
        label.numberOfLines = numberOfLines
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.text = text
        return label
    }

    func makeTextField(withPlacegolder placeholder: String? = nil, isSecured: Bool = false) -> UITextField {
        let textField = UITextField()
        textField.layer.cornerRadius = 16
        textField.layer.masksToBounds = true
        textField.backgroundColor = .iecCream
        textField.textColor = .iecPurpleDark
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.iecPurpleLight.withAlphaComponent(0.25)])
        if let button = textField.value(forKey: "clearButton") as? UIButton {
          button.tintColor = .iecPurpleDark
          button.setImage(UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        textField.clearButtonMode = .whileEditing
        textField.textAlignment = .center
        if isSecured {
            textField.isSecureTextEntry = true
        }
        return textField
    }

    func makeImageView(withImageNamed imageName: String? = nil
    ) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        if let imageName {
            imageView.image = UIImage(named: imageName)
        }
        return imageView
    }

    func makeButton(withTitle title: String, andAction selector: Selector) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.backgroundColor = .iecPurpleLight
        button.tintColor = .iecCream
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.appFont(.bold, withSize: 16)
        button.addTarget(nil, action: selector, for: .touchUpInside)
        return button
    }

    func makeTable(withCells cells: (type: UITableViewCell.Type, identifier: String)...) -> UITableView {
        let tableView = UITableView()
        tableView.toAutolayout()
        for singleCell in cells {
            tableView.register(singleCell.type, forCellReuseIdentifier: singleCell.identifier)
        }
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }

    func makeActivityIndicator(withColor color: UIColor) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = color
        return activityIndicator
    }

    func makeSearchTextField() -> UISearchTextField {
        let searchField = UISearchTextField()
        searchField.placeholder = "SEARCH".localized
        searchField.backgroundColor = .iecPurple.withAlphaComponent(0.12)
        searchField.textColor = .iecCream
        searchField.attributedPlaceholder = NSAttributedString(
            string: searchField.placeholder ?? "",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.iecPurpleLight
            ]
        )
        if let leftView = searchField.leftView as? UIImageView {
            leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
            leftView.tintColor = UIColor.iecPurpleLight
        }
        searchField.clearButtonMode = .never
        return searchField
    }

    func makeStackView(axis: NSLayoutConstraint.Axis = .vertical,
                       alignment: UIStackView.Alignment = .fill,
                       distribution: UIStackView.Distribution = .fill,
                       backgroundColor: UIColor = .clear,
                       addingSpacing spacing: CGFloat = 4
    ) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.backgroundColor = backgroundColor
        stackView.spacing = spacing
        return stackView
    }
}
