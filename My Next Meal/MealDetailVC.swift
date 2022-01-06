//
//  MealDetailVC.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/5/22.
//

import UIKit

class MealDetailVC: UIViewController {

    var meal: Meal!
    var mealDetail: MealDetail? = nil

    let mealImageView = NMFoodImageView(frame: .zero)
    let titleLabel = NMTitleLabel()
    let instructionsLabel = NMBodyLabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureSubView()
        getMealDetails()
    }

    private func configure() {
        view.backgroundColor = .systemBackground

        navigationItem.largeTitleDisplayMode = .never
    }

    private func configureSubView() {
        view.addSubview(mealImageView)
        view.addSubview(titleLabel)
        view.addSubview(instructionsLabel)

        NSLayoutConstraint.activate([
            mealImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mealImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mealImageView.widthAnchor.constraint(equalToConstant: 144),
            mealImageView.heightAnchor.constraint(equalToConstant: 144),

            titleLabel.topAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: mealImageView.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 16),

            instructionsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            instructionsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ])
    }

    private func getMealDetails() {
        Task {
            do {
                let mealDetail = try await NetworkManager.shared.getMealDetails(mealID: meal.id)
                print(mealDetail.ingredients, mealDetail.ingredients.count)
                updateUI(with: mealDetail)
            } catch {
                print("There was an error retreiving ")
            }
        }
    }

    func updateUI(with mealDetail: MealDetail) {
        self.mealDetail = mealDetail
        DispatchQueue.main.async {
            self.titleLabel.text = mealDetail.name
            self.instructionsLabel.text = mealDetail.instructions.replacingOccurrences(of: "\r", with: "\r\r")
            self.mealImageView.downloadImage(fromURL: mealDetail.imageURLString)
        }
    }

}
