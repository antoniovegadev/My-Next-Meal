//
//  NMMealCell.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/5/22.
//

import UIKit

class NMMealCell: UITableViewCell {

    static let reuseID = "NMMealCell"

    let mealImageView = NMFoodImageView(frame: .zero)
    let titleLabel = NMTitleLabel(fontSize: 16, textAlignment: .left, weight: .medium)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(meal: Meal) {
        titleLabel.text = meal.name
        mealImageView.downloadImage(fromURL: meal.imageURLString)
    }

    private func configure() {
        addSubview(mealImageView)
        addSubview(titleLabel)

        let horizontalPadding: CGFloat = 10

        NSLayoutConstraint.activate([
            mealImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalPadding),
            mealImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mealImageView.widthAnchor.constraint(equalToConstant: 60),
            mealImageView.heightAnchor.constraint(equalToConstant: 60),

            titleLabel.leadingAnchor.constraint(equalTo: mealImageView.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalPadding)
        ])
    }

}
