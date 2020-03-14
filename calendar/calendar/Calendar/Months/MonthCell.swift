//
//  MonthCell.swift
//  calendar
//
//  Created by Adam Jessop on 11/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit
 
class MonthCell: UICollectionViewCell {
    
    var month: Month?
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        collectionView.dataSource = CalendarDataManager.shared.activeMonthDataSource
        collectionView.delegate = CalendarDataManager.shared.activeMonthDelegate
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 50, height: 50)
        collectionView.setCollectionViewLayout(layout, animated: false)
        return collectionView
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        backgroundColor = .clear
        collectionView.backgroundColor = .clear
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
}
