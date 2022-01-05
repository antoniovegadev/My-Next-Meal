//
//  NMCategoryCell.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

import UIKit

class NMCategoryCell: UITableViewCell {

    static let reuseID = "NMCategoryCell"

    let foodImageView = UIImageView(image: UIImage(systemName: "photo"))
    let titleLabel = UILabel()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureFoodImageView()
        configureTitleLabel()
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(category: Category) {
        titleLabel.text = category.category
    }

    private func configureFoodImageView() {
        foodImageView.layer.cornerRadius = 10
        foodImageView.clipsToBounds = true
        foodImageView.contentMode = .scaleAspectFit

        foodImageView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureTitleLabel() {
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func layoutUI() {
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
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalPadding)
        ])
    }

}
