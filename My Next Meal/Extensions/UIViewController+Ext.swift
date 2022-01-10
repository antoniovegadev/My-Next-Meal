//
//  UIViewController+Ext.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/7/22.
//

import UIKit

extension UIViewController {
    func presentNMAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            print("Ok was tapped")
        }

        alert.addAction(action)

        self.present(alert, animated: true)
    }

    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}
