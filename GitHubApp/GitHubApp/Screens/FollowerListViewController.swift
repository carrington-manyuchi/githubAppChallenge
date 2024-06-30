//
//  FollowerListViewController.swift
//  GitHubApp
//
//  Created by Manyuchi, Carrington C on 2024/06/28.
//

import UIKit

class FollowerListViewController: UIViewController {
    
    var username: String!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        getFollowers()
        configureViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        configureUICollectionView()
    }
    
    func configureUICollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseID)
        collectionView.backgroundColor = .systemPink
        view.addSubview(collectionView)

    }
    
    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize = CGSize(width: itemWidth, height: (itemWidth + 40))

        return flowlayout
    }
    
    private func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { (result) in
            switch result {
            case .success(let followers):
                print("Number of Followers \(followers.count)")
                print(followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
