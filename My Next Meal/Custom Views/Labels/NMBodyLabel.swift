//
//  NMBodyLabel.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/5/22.
//

import UIKit

class NMBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        font = .preferredFont(forTextStyle: .body)
        textColor = .secondaryLabel
        numberOfLines = 0
        lineBreakStrategy = .standard
        translatesAutoresizingMaskIntoConstraints = false
    }

}
