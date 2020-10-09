//
//  HourlyTableviewCell.swift
//  WeatherApp
//
//  Created by Beau Nouvelle on 2020-10-08.
//

import Foundation
import UIKit

final class HourlyTableViewCell: UITableViewCell {

    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        let layout = UICollectionViewFlowLayout()

        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true

        collectionView.backgroundColor = .red
    }
}
