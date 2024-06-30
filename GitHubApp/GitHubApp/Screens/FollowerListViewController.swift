//
//  FollowerListViewController.swift
//  GitHubApp
//
//  Created by Manyuchi, Carrington C on 2024/06/28.
//

import UIKit

class FollowerListViewController: UIViewController {
    
    enum Section { case main }
    
    var username: String!
    var followers: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        getFollowers()
        configureViews()
        configureDataSource()
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
        collectionView.backgroundColor = .systemBackground
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
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let followers):
                self.followers = followers
                self.updateData()
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseID, for: indexPath) as? FollowerCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
}
