//
//  NMTextSection.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/6/22.
//

import UIKit
import SwiftUI

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

    private func configure() {
        addSubview(sectionTitleLabel)
        addSubview(descriptionTitlelabel)

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            sectionTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            sectionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            sectionTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

            descriptionTitlelabel.topAnchor.constraint(equalTo: sectionTitleLabel.bottomAnchor, constant: 10),
            descriptionTitlelabel.leadingAnchor.constraint(equalTo: sectionTitleLabel.leadingAnchor),
            descriptionTitlelabel.trailingAnchor.constraint(equalTo: sectionTitleLabel.trailingAnchor),
            descriptionTitlelabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }

    func set(sectionTitle: String, description: String) {
        sectionTitleLabel.text = sectionTitle
        descriptionTitlelabel.text = description
    }

}

struct NMTextSectionContainer: UIViewRepresentable {

    let sectionTitle: String!
    let description: String!

    func makeUIView(context: Context) -> some UIView {
        return NMTextSection(sectionTitle: sectionTitle, description: description)
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }

}

struct NMTextSection_Previews: PreviewProvider {
    static var previews: some View {
        NMTextSectionContainer(sectionTitle: "Ingredients", description: "These are the ingredients.")
            .preferredColorScheme(.light)
            .previewLayout(.fixed(width: 250, height: 300))

        NMTextSectionContainer(sectionTitle: "Ingredients", description: "These are the ingredients.")
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 250, height: 300))
    }
}
