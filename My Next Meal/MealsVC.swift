//
//  MealsVC.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/5/22.
//

import UIKit

class MealsVC: UIViewController {

    var category: Category!

    let tableView = UITableView()
    var meals: [Meal] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureTableView()
        getMeals()
    }

    private func configure() {
        view.backgroundColor = .systemBackground

        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = category.category
    }

    private func configureTableView() {
        view.addSubview(tableView)

        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(NMMealCell.self, forCellReuseIdentifier: NMMealCell.reuseID)
    }

    private func updateUI(with meals: [Meal]) {
        self.meals = meals
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    private func getMeals() {
        Task {
            do {
                let meals = try await NetworkManager.shared.getMeals(in: category.category)
                updateUI(with: meals)
            } catch {
                print("There was an error fetching \(category.category) meals.")
            }
        }
    }

}

extension MealsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NMMealCell.reuseID) as! NMMealCell
        let meal = meals[indexPath.row]

        cell.set(meal: meal)

        return cell
    }

}
