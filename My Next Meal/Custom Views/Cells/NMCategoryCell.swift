//
//  NMCategoryCell.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

import UIKit

class NMCategoryCell: UITableViewCell {

    static let reuseID = "NMCategoryCell"

    let foodImageView = NMFoodImageView(frame: .zero)
    let titleLabel = NMTitleLabel()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(category: Category) {
        titleLabel.text = category.category
        foodImageView.downloadImage(fromURL: category.imageURLString)
    }

    private func configure() {
        addSubview(foodImageView)
        addSubview(titleLabel)
        
        let horizontalPadding: CGFloat = 10

        NSLayoutConstraint.activate([
            foodImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalPadding),
            foodImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            foodImageView.widthAnchor.constraint(equalToConstant: 60),
            foodImageView.heightAnchor.constraint(equalToConstant: 60),

            titleLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalPadding)
        ])
    }

}
