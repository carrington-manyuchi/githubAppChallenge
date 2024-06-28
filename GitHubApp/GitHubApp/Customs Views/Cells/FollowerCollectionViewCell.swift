//
//  FollowerCollectionViewCell.swift
//  GitHubApp
//
//  Created by Manyuchi, Carrington C on 2024/06/28.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCollectionViewCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(follower: Follower) {
        usernameLabel.text = follower.login
       // avatarImageView.image = follower.avatarUrl
    }
    
    private func configureView() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        configureConstraints()
    }
    
    private func configureConstraints() {
        let padding: CGFloat = 8
        
        let avatarImageViewConstraints = [
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
        ]
        
        let usernameLabelConstraints = [
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        NSLayoutConstraint.activate(avatarImageViewConstraints)
        NSLayoutConstraint.activate(usernameLabelConstraints)
    }
    
    
}
