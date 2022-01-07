//
//  NMFoodImageView.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

import UIKit

class NMFoodImageView: UIImageView {

    let placeholder = UIImage(systemName: "photo")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false

        image = placeholder
    }

    func downloadImage(fromURL url: String) {
        image = placeholder
        
        Task {
            image = await NetworkManager.shared.downloadImage(from: url) ?? placeholder
        }
    }
    
}
