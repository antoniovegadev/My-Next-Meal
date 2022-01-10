//
//  CategoriesVC.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

import UIKit

class CategoriesVC: NMDataLoadingVC {
    
    enum Section: CaseIterable {
        case main
    }

    var categories: [Category] = []

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Category>!


    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureCollectionView()
        configureDataSource()
        getCategories()
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground

        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.title = "Categories"
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view)
        )
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(NMCategoryCell.self, forCellWithReuseIdentifier: NMCategoryCell.reuseID)
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Category>(collectionView: collectionView, cellProvider: { collectionView, indexPath, category in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NMCategoryCell.reuseID, for: indexPath) as! NMCategoryCell
            cell.set(category: category)
            return cell
        })
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
            self.updateData(on: self.categories)
        }
    }

    private func updateData(on categories: [Category]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Category>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(categories, toSection: .main)

        dataSource.apply(snapshot)
    }

}

extension CategoriesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let category = dataSource.itemIdentifier(for: indexPath) else {
            fatalError("didSelectItemAt index \(indexPath.row) does not exist.")
        }

        let destVC = MealsVC()
        destVC.category = category

        navigationController?.pushViewController(destVC, animated: true)
    }
}
