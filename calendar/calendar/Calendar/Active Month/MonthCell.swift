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
    var dateLabel: UILabel?
    var collectionView: MonthCollectionView?
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        backgroundColor = .clear
    }

    func setupCell() {
        setupLabel()
        setupCollectionView()
        if let monthName = month?.name, let yearNumber = month?.year.number, let dateLabel = dateLabel {
            dateLabel.text = "\(monthName) \(yearNumber)"
        }
    }
    
    private func setupLabel() {
        dateLabel = UILabel()
        guard let label = dateLabel else {return}
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.widthAnchor.constraint(equalToConstant: 300),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
    }
    
    private func setupCollectionView() {
        collectionView = MonthCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        guard let collectionView = collectionView, let dateLabel = dateLabel else {return}
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: "Cell")
        addSubview(collectionView)
        collectionView.month = month
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 40),
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
        collectionView.backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        month = nil
        collectionView = nil
        dateLabel?.text = nil
        dateLabel = nil
    }
    
}

class MonthCollectionView: UICollectionView {
    
    weak var month: Month?
    
}
