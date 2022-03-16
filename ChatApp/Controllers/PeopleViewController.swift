//
//  PeopleViewController.swift
//  ChatApp
//
//  Created by Vasichko Anna on 14.02.2022.
//

import UIKit

class PeopleViewController: UIViewController {
    
    let users = Bundle.main.decode([MUser].self, from: "users.json")
    
    enum Section: Int, CaseIterable {
        case users
        
        func makeDescription(usersCount: Int) -> String {
            switch self {
            case .users:
                return "\(usersCount) users nearby"
            }
        }
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, MUser>?
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainWhite()
        setupSearchBar()
        setupCollectionView()
        createDataSource()
        reloadData()
    }
    private func setupSearchBar() {
        navigationController?.navigationBar.barTintColor = .mainWhite()
        navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController?.searchBar.tintColor = #colorLiteral(red: 0.5304797292, green: 0.2621831894, blue: 0.5647147298, alpha: 1)
        searchController.searchBar.delegate = self
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .mainWhite()
        view.addSubview(collectionView)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseID)
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseID)
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MUser>()
        snapshot.appendSections([.users])
        snapshot.appendItems(users, toSection: .users)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Compositional Layout

extension PeopleViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .users:
                return self.createUsersSection()
            }
            
        }
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        layout.configuration = configuration
        return layout
    }
    
    private func createUsersSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(16)
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 16, bottom: 0, trailing: 16)
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeader
    }
}

// MARK: - Data Source
extension PeopleViewController {
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, MUser>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, user) ->
            UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .users:
                return self.configure(collectionView: collectionView, cellType: UserCell.self, with: user, for: indexPath)
            }
        })
        
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseID, for: indexPath) as? SectionHeader else {
                fatalError("Cannot create new section header")
            }
            guard let section = Section(rawValue: indexPath.section) else {fatalError("Unknown section kind")}
            let items = self.dataSource!.snapshot().itemIdentifiers(inSection: .users)
            sectionHeader.configure(text: section.makeDescription(usersCount: items.count), font: .arial36()!, textColor: .systemGray)
            
            return sectionHeader
        }

    }
}
// MARK: - UISearchBarDelegate
extension PeopleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
// MARK: - SwiftUI
import SwiftUI

struct PeopleViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all).previewInterfaceOrientation(.portrait)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<PeopleViewControllerProvider.ContainerView>) -> MainTabBarController {
           viewController
        }
        
        func updateUIViewController(_ uiViewController: PeopleViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<PeopleViewControllerProvider.ContainerView>) {
        }
    }
}
