//
//  NMIngredientView.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/8/22.
//

import UIKit

class NMIngredientView: UIView {

    let imageView = NMFoodImageView(frame: .zero)
    let ingredientLabel = NMBodyLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(ingredient: Ingredient) {
        imageView.downloadImage(fromURL: ingredient.imageURLString)
        ingredientLabel.text = "\(ingredient.name) - \(ingredient.measurement)"
    }

    func configure() {
        addSubview(imageView)
        addSubview(ingredientLabel)

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),

            ingredientLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            ingredientLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ingredientLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

}
