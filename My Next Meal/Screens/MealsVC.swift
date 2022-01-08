//
//  MealsVC.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/5/22.
//

import UIKit

class MealsVC: NMDataLoadingVC {

    var category: Category!

    let tableView = UITableView()
    var meals: [Meal] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureTableView()
        getMeals()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
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

    private func updateUI(with meals: MealAPIResponse) {
        self.meals = meals.meals.sorted { $0.name < $1.name }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    private func getMeals() {
        showLoadingView()
        Task {
            do {
                let response: MealAPIResponse = try await NetworkManager.shared.getRequest(.getMealsByCategory, parameter: category.category)
                updateUI(with: response)
                dismissLoadingView()
            } catch {
                if let nmError = error as? NMError {
                    presentNMAlert(title: "Something went wrong", message: nmError.rawValue, buttonTitle: "Ok")
                } else {
                    presentNMAlert(title: "Something went wrong", message: "Unable to complete task at this time. Please try again.", buttonTitle: "Ok")
                }
                dismissLoadingView()
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = MealDetailVC()
        let meal = meals[indexPath.row]

        destVC.mealID = meal.id

        navigationController?.pushViewController(destVC, animated: true)
    }

}
