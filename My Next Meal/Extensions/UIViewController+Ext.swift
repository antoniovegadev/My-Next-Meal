//
//  UIViewController+Ext.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/7/22.
//

import Foundation
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

}
