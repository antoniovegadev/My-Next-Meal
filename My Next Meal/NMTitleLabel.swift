//
//  NMTitleLabel.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

import UIKit

class NMTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        font = .preferredFont(forTextStyle: .headline)
        textColor = .label
        translatesAutoresizingMaskIntoConstraints = false
    }

}
