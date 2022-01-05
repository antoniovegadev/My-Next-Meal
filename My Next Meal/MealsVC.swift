//
//  MealsVC.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

import UIKit

class MealsVC: UIViewController {

    let tableView = UITableView()
    var categories: [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureTableView()
        getCategories()
    }

    private func configure() {
        view.backgroundColor = .systemBackground

        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.title = "Categories"
    }

    private func configureTableView() {
        view.addSubview(tableView)

        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(NMCategoryCell.self, forCellReuseIdentifier: NMCategoryCell.reuseID)
    }

    private func getCategories() {
        Task {
            do {
                let categories = try await NetworkManager.shared.getCategories()
                updateUI(with: categories)
            } catch {
                print("There was an error")
            }
        }
    }

    private func updateUI(with categories: [Category]) {
        self.categories = categories
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension MealsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NMCategoryCell.reuseID) as! NMCategoryCell
        let category = categories[indexPath.row]

        cell.set(category: category)

        return cell
    }

}
