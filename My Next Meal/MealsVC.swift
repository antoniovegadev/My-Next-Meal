//
//  MealsVC.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

import UIKit

class MealsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        getCategories()
    }

    private func configure() {
        view.backgroundColor = .systemBackground

        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.title = "Meals"
    }

    private func getCategories() {
        Task {
            do {
                let categories = try await NetworkManager.shared.getCategories()
                print(categories)
            } catch {
                print("There was an error")
            }
        }
    }

}
