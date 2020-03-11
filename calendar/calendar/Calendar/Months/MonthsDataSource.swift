//
//  MonthsDataSource.swift
//  calendar
//
//  Created by Adam Jessop on 11/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit

class MonthsDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CoreDataManager.shared.calendar!.years.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MonthCell,
            let months = sortedMonths[indexPath.row]
            {
            cell.month = month
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
}
