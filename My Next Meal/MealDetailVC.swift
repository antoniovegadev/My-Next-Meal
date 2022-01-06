//
//  MealDetailVC.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/5/22.
//

import UIKit
import SwiftUI /* used only for creating Live Previews */

class MealDetailVC: UIViewController {

    var mealID: String!

    let scrollView = UIScrollView()
    let contentView = UIView()

    let mealImageView = NMFoodImageView(frame: .zero)
    let titleLabel = NMTitleLabel()
    let instructionsLabel = NMBodyLabel()


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
        contentView.addSubview(instructionsLabel)

        titleLabel.textAlignment = .center

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
            mealImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mealImageView.widthAnchor.constraint(equalToConstant: 144),
            mealImageView.heightAnchor.constraint(equalToConstant: 144),

            titleLabel.topAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: mealImageView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),

            instructionsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            instructionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            instructionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            instructionsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }

    private func getMealDetails() {
        Task {
            do {
                let mealDetail = try await NetworkManager.shared.getMealDetails(mealID: mealID)
                print(mealDetail.ingredients, mealDetail.ingredients.count)
                updateUI(with: mealDetail)
            } catch {
                print("There was an error retreiving ")
            }
        }
    }

    func updateUI(with mealDetail: MealDetail) {
        DispatchQueue.main.async {
            self.titleLabel.text = mealDetail.name
            self.instructionsLabel.text = mealDetail.instructions.replacingOccurrences(of: "\r", with: "\r\r")
            self.mealImageView.downloadImage(fromURL: mealDetail.imageURLString)
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
