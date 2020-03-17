//
//  ActiveMonthDelegate.swift
//  calendar
//
//  Created by Adam Jessop on 11/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit

class ActiveMonthDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/7, height: collectionView.frame.height/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CalendarCell,
            let sortedDays = DateManager.getSortedListOfDays(days: CalendarDataManager.shared.currentMonth.days.allObjects) {
            cell.day = sortedDays[indexPath.row] as Day
            CalendarDataManager.shared.currentDay = cell.day
            CalendarDataManager.shared.currentMonth = cell.day?.month
            CalendarDataManager.shared.currentYear = cell.day?.month.year
        }
    }
    
}
