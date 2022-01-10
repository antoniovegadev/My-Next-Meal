//
//  NMIngredientsVC.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/8/22.
//

import UIKit

class NMIngredientsVC: UIViewController {

    var ingredients: [Ingredient]!

    let titleLabel = NMTitleLabel(fontSize: 30, textAlignment: .left, weight: .medium)
    let stackView = UIStackView()
    var ingredientSubViews: [NMIngredientView] = []
    

    init(ingredients: [Ingredient]) {
        super.init(nibName: nil, bundle: nil)
        self.ingredients = ingredients
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createSubViews()
        configure()
        configureStackView()
        layoutUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calculatePreferredSize()
    }

    private func calculatePreferredSize() {
        let targetSize = CGSize(width: view.bounds.width,
                                height: UIView.layoutFittingCompressedSize.height)
        preferredContentSize = view.systemLayoutSizeFitting(targetSize)
    }

    private func createSubViews() {
        for ingredient in ingredients {
            let ingredientView = NMIngredientView()
            ingredientView.set(ingredient: ingredient)
            ingredientSubViews.append(ingredientView)
        }
    }

    private func configure() {
        titleLabel.text = "Ingredients"
        view.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureStackView() {
        stackView.axis = .vertical
        stackView.spacing = 90
        stackView.alignment = .leading

        for ingredientSubView in ingredientSubViews {
            stackView.addArrangedSubview(ingredientSubView)
        }

        stackView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func layoutUI() {
        view.addSubview(titleLabel)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 45),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
