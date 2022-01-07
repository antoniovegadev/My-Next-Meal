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

    convenience init(fontSize: CGFloat, textAlignment: NSTextAlignment, weight: UIFont.Weight = .regular) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = .systemFont(ofSize: fontSize, weight: weight)
    }

    private func configure() {
        textColor = .label
        numberOfLines = 0
        lineBreakStrategy = .standard
        translatesAutoresizingMaskIntoConstraints = false
    }

}
