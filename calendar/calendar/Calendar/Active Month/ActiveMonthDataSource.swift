//
//  ActiveMonthDataSource.swift
//  calendar
//
//  Created by Adam Jessop on 11/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit

class ActiveMonthDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let monthCollectionView = collectionView as? MonthCollectionView, let dayCount = monthCollectionView.month?.days.allObjects.count {
            return dayCount
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? DayCell,
            let monthCollectionView = collectionView as? MonthCollectionView,
            let day = monthCollectionView.month?.days.allObjects[indexPath.row] as? Day {
            cell.dateLabel.text = "\(indexPath.row + 1)"
            cell.day = day
            if DateManager.checkIfToday(day: day) {
                CoreDataManager.shared.today = day
            }
            cell.setupCell()
            return cell
        }
        return UICollectionViewCell()
    }
    
}
