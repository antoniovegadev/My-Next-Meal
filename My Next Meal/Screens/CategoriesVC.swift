//
//  CategoriesVC.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

import UIKit

class CategoriesVC: NMDataLoadingVC {

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
        showLoadingView()
        Task {
            do {
                let response: CategoryAPIResponse = try await NetworkManager.shared.getRequest(.getCategories)
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

    private func updateUI(with categories: CategoryAPIResponse) {
        self.categories = categories.categories.sorted { $0.category < $1.category }
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
