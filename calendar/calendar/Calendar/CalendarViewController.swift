//
//  CalendarViewController.swift
//  calendar
//
//  Created by Adam Jessop on 29/02/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var previousMonthButton: UIButton!
    @IBOutlet weak var nextMonthButton: UIButton!
    var currentYear: Year!
    var currentMonth: Month!
    var selectedIndex: Int?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.shared.setupData()
        let yearAndMonth = DateManager.getCurrentYearAndMonthObject()
        currentYear = yearAndMonth.0
        currentMonth = yearAndMonth.1
        DateManager.currentDate = Date()
        monthLabel.text = "\(currentMonth.name) \(currentYear.number) "
        nextMonthButton.imageView?.image = nextMonthButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        nextMonthButton.imageView?.image?.withTintColor(.white)
        previousMonthButton.imageView?.image = previousMonthButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        previousMonthButton.imageView?.image?.withTintColor(.white)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentMonth.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CalendarCell {
            if let _ = selectedIndex, indexPath.row == selectedIndex {
                cell.backgroundColor = .purple
            }
            cell.dateLabel.text = "\(indexPath.row + 1)"
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/7, height: collectionView.frame.height/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _ = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CalendarCell {
            selectedIndex = indexPath.row
            collectionView.reloadData()
        }
    }
    
    @IBAction func previousMonthPressed(_ sender: Any) {
        let yearAndMonth = DateManager.getPreviousYearAndMonthObject(currentYear: currentYear, currentMonth: currentMonth)
        currentYear = yearAndMonth.0
        currentMonth = yearAndMonth.1
        monthLabel.text = "\(currentMonth.name) \(currentYear.number) "
        collectionView.reloadData()
    }
    
    @IBAction func nextMonthPressed(_ sender: Any) {
        let yearAndMonth = DateManager.getNextYearAndMonthObject(currentYear: currentYear, currentMonth: currentMonth)
        currentYear = yearAndMonth.0
        currentMonth = yearAndMonth.1
        monthLabel.text = "\(currentMonth.name) \(currentYear.number) "
        collectionView.reloadData()
    }
    
}
