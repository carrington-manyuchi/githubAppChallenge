//
//  GFAvatarImageView.swift
//  GitHubApp
//
//  Created by Manyuchi, Carrington C on 2024/06/28.
//

import UIKit

class GFAvatarImageView: UIImageView {

    let placeholder = UIImage(named: "avatar-placeholder")!
    
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
        image = placeholder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
