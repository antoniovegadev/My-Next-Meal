//
//  NMTextSection.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/6/22.
//

import UIKit

class NMTextSection: UIView {

    let sectionTitleLabel = NMTitleLabel(fontSize: 30, textAlignment: .left, weight: .medium)
    let descriptionTitlelabel = NMBodyLabel()
    

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(sectionTitle: String, description: String) {
        self.init(frame: .zero)
        set(sectionTitle: sectionTitle, description: description)
    }

    func set(sectionTitle: String, description: String) {
        sectionTitleLabel.text = sectionTitle
        descriptionTitlelabel.text = description
    }

    private func configure() {
        addSubview(sectionTitleLabel)
        addSubview(descriptionTitlelabel)

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            sectionTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            sectionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sectionTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            descriptionTitlelabel.topAnchor.constraint(equalTo: sectionTitleLabel.bottomAnchor, constant: 10),
            descriptionTitlelabel.leadingAnchor.constraint(equalTo: sectionTitleLabel.leadingAnchor),
            descriptionTitlelabel.trailingAnchor.constraint(equalTo: sectionTitleLabel.trailingAnchor),
            descriptionTitlelabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}
