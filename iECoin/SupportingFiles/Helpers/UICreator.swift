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
        return tableView
    }

    func makeActivityIndicator(withColor color: UIColor) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = color
        return activityIndicator
    }
//
//    func makeSearchBar() -> UISearchBar {
//        let searchBar = UISearchBar()
//        searchBar.toAutolayout()
//        searchBar.barTintColor = .bbdbBlue
//        searchBar.backgroundImage = UIImage()
//        return searchBar
//    }
//
//    func makePageControll() -> UIPageControl {
//        let pageControl = UIPageControl()
//        pageControl.toAutolayout()
//        pageControl.isEnabled = false
//        pageControl.backgroundColor = .clear
//        pageControl.currentPageIndicatorTintColor = .bbdbRed
//        pageControl.pageIndicatorTintColor = .bbdbRed.withAlphaComponent(0.3)
//        pageControl.numberOfPages = 5
//        return pageControl
//    }
//
//    func makeSwitch(withAction action: Selector, andCurrentState state: Bool) -> UISwitch {
//        let uiSwitch = UISwitch()
//        uiSwitch.toAutolayout()
//        uiSwitch.isOn = state
//        uiSwitch.addTarget(nil, action: action, for: UIControl.Event.valueChanged)
//        uiSwitch.onTintColor = .bbdbBlack
//        uiSwitch.thumbTintColor = .bbdbWhite
//        return uiSwitch
//    }
//
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

//    func makeLabelStack(leadingText: String,
//                        trailingText: String,
//                        textColor: UIColor = .iecCream,
//                        backgroundColor: UIColor = .iecPurple,
//                        intersectionColor: UIColor = .iecPurpleLight
//    ) -> UIStackView {
//        let stackView = makeStackView(axis: .horizontal,
//                                      alignment: .fill,
//                                      distribution: .fillEqually,
//                                      backgroundColor: backgroundColor)
//        stackView.layer.borderWidth = 2
//        stackView.layer.borderColor = intersectionColor.cgColor
//        stackView.addArrangedSubview(makeLabel(text: leadingText,
//                                               font: UIFont.appFont(.bold, withSize: 23),
//                                               color: textColor))
//        stackView.addArrangedSubview(makeLabel(text: trailingText,
//                                               font: UIFont.appFont(.bold, withSize: 23),
//                                               color: textColor,
//                                               alignment: .left))
//        return stackView
//    }
//
//    func makeScrollView() -> UIScrollView {
//        let scrollView = UIScrollView()
//        scrollView.toAutolayout()
//        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * 5, height: 0)
//        scrollView.isPagingEnabled = true
//        scrollView.showsHorizontalScrollIndicator = false
//        return scrollView
//    }
//
//    func makeTextViewWithLink() -> UITextView {
//        let attributedString = NSMutableAttributedString(string: "This app was made, using bobsburgersapi.com API")
//        attributedString.addAttribute(.link,
//                                      value: "https://www.bobsburgersapi.com",
//                                      range: NSRange(location: 25, length: 18))
//        let textView = UITextView()
//        textView.toAutolayout()
//        textView.backgroundColor = .clear
//        textView.attributedText = attributedString
//        textView.textAlignment = .center
//        textView.font = UIFont(name: "Kailasa Bold", size: 12)
//        textView.textColor = .bbdbBlack
//        textView.isEditable = false
//        textView.dataDetectorTypes = .link
//        return textView
//    }
}
