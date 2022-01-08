//
//  MealDetailVC.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/5/22.
//

import UIKit
import SwiftUI /* used only for creating Live Previews */

class MealDetailVC: NMDataLoadingVC {

    var mealID: String!

    let scrollView = UIScrollView()
    let contentView = UIView()

    let mealImageView = NMFoodImageView(frame: .zero)
    let titleLabel = NMTitleLabel(fontSize: 22, textAlignment: .center, weight: .medium)
    let ingredientsView = NMTextSection(frame: .zero)
    let instructionsView = NMTextSection(frame: .zero)


    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureSubViews()
        getMealDetails()
    }

    private func configure() {
        view.backgroundColor = .systemBackground

        navigationItem.largeTitleDisplayMode = .never
    }

    private func configureSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mealImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ingredientsView)
        contentView.addSubview(instructionsView)

        mealImageView.contentMode = .scaleAspectFill

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            mealImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            mealImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            mealImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            mealImageView.heightAnchor.constraint(equalToConstant: 250),

            titleLabel.topAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: mealImageView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),

            ingredientsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            ingredientsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            ingredientsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            instructionsView.topAnchor.constraint(equalTo: ingredientsView.bottomAnchor, constant: 30),
            instructionsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            instructionsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            instructionsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }

    private func getMealDetails() {
        showLoadingView()
        Task {
            do {
                let response: MealDetailAPIResponse = try await NetworkManager.shared.getRequest(.getMealDetails, parameter: mealID)
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

    func updateUI(with mealDetail: MealDetailAPIResponse) {
        let meal = mealDetail.meals.first!
        DispatchQueue.main.async {
            self.titleLabel.text = meal.name
            self.ingredientsView.set(sectionTitle: "Ingredients", description: String(meal.ingredients.reduce("", { $0 + "\($1.name) - \($1.measurement)\r"}).dropLast()))
            self.instructionsView.set(sectionTitle: "Instructions", description: meal.instructions)
            self.mealImageView.downloadImage(fromURL: meal.imageURLString)
        }
    }

}

struct MealDetailContainerView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = MealDetailVC()
        vc.mealID = "52965"

        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }

}

struct MealDetailVC_Preview: PreviewProvider {
    static var previews: some View {
        MealDetailContainerView()
    }
}