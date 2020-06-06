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
    
    var dateLabel: UILabel {
        let label = UILabel()
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }
    
    lazy var collectionView: MonthCollectionView = {
        let collectionView = MonthCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        addSubview(collectionView)
        collectionView.month = month
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 40),
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
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        backgroundColor = .clear
        collectionView.backgroundColor = .clear
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: "Cell")
        if let monthName = month?.name, let yearNumber = month?.year.number {
            dateLabel.text = "\(monthName) \(yearNumber)"
        }
    }
    
}

class MonthCollectionView: UICollectionView {
    
    var month: Month?
    
}
