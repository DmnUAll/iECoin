//
//  NavigationController.swift
//  iECoin
//
//  Created by Илья Валито on 16.04.2023.
//

import UIKit

// MARK: - SortingDelegate protocol
protocol SortingDelegate: AnyObject {
    func sortItems(using sortingDirection: SortingDirections)
}

// MARK: - NavigationController
final class NavigationController: UINavigationController {

    // MARK: - Properties and Initializers
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }

    weak var sortingDelegate: SortingDelegate?

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configureNavigationController()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Helpers
extension NavigationController {

    @objc private func logoutButtonTapped() {
        let alertController = UIAlertController(title: "LOGOUT_WARNING".localized,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "LOG_OUT".localized,
                                         style: .destructive
        ) { _ in
            UserDefaultsManager.shared.updateLoginState()
            UIApplication.shared.keyWindow?.rootViewController = LoginScreenController()
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        }
        let cancelAction = UIAlertAction(title: "CANCEL".localized, style: .cancel)
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

    private func configureNavigationController() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [
            .font: UIFont.appFont(.bold, withSize: 24),
            .foregroundColor: UIColor.iecCream
        ]
        navBarAppearance.titlePositionAdjustment.vertical = 5
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.iecCream]
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.tintColor = .iecCream
//        navigationBar.topItem?.title = navVCTitle
        let iconSize = 48
        let incrementSorting = UIAction(
            title: "INCREMENT_SORTING".localized,
            subtitle: nil,
            image: UIImage(named: K.IconsNames.incrementSorting)?.resize(targetSize: CGSize(width: iconSize,
                                                                                             height: iconSize)),
            handler: { [weak self] _ in
                guard let self = self else { return }
                self.sortingDelegate?.sortItems(using: .incrementByDailyPrice)
            })
        let decrementSorting = UIAction(
            title: "DECREMENT_SORTING".localized,
            subtitle: nil,
            image: UIImage(named: K.IconsNames.decrementSorting)?.resize(targetSize: CGSize(width: iconSize,
                                                                                   height: iconSize)),
            handler: { [weak self] _ in
                guard let self = self else { return }
                self.sortingDelegate?.sortItems(using: .decrementByDailyPrice)
            })
        let menuItems: [UIAction] = [incrementSorting, decrementSorting]
        let buttonMenu = UIMenu(title: "SORTING_SETTINGS".localized,
                                image: nil,
                                identifier: nil,
                                options: [],
                                children: menuItems)
        let sortingButton = UIBarButtonItem(
            title: nil,
            image: UIImage(named: K.IconsNames.sorting)?.resize(targetSize: CGSize(width: iconSize, height: iconSize)),
            primaryAction: nil, menu: buttonMenu)
        navigationBar.topItem?.leftBarButtonItem = sortingButton
        navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: K.IconsNames.logout)?.resize(targetSize: CGSize(width: iconSize,
                                                                                   height: iconSize)),
            style: .plain,
            target: nil,
            action: #selector(logoutButtonTapped))
    }
}
