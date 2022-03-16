//
//  UIViewController + Extension.swift
//  ChatApp
//
//  Created by Vasichko Anna on 16.03.2022.
//

import UIKit

extension UIViewController {
    func configure<T: SelfConfiguringCell, U: Hashable>(collectionView: UICollectionView, cellType: T.Type, with value: U, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseID, for: indexPath) as? T else {fatalError("Unable to dequeue \(cellType)")}
        cell.configure(with: value)
        return cell
    }
}
