//
//  NMCategoryCell.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

import UIKit

class NMCategoryCell: UICollectionViewCell {

    static let reuseID = "NMCategoryCell"

    let foodImageView = NMImageView(frame: .zero)
    let titleLabel = NMTitleLabel(fontSize: 16, textAlignment: .left, weight: .medium)


    override init(frame: CGRect) {
        super.init(frame: frame)

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
        
        let padding: CGFloat = 8

        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            foodImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            foodImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            foodImageView.heightAnchor.constraint(equalTo: foodImageView.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

}
