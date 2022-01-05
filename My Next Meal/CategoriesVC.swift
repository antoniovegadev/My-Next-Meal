//
//  CategoriesVC.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

import UIKit

class CategoriesVC: UIViewController {

    let tableView = UITableView()
    var categories: [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureTableView()
        getCategories()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
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
                updateUI(with: categories.sorted { $0.category < $1.category })
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

extension CategoriesVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NMCategoryCell.reuseID) as! NMCategoryCell
        let category = categories[indexPath.row]

        cell.set(category: category)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = MealsVC()
        let category = categories[indexPath.row]

        destVC.category = category

        navigationController?.pushViewController(destVC, animated: true)
    }

}
