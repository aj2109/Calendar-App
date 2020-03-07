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
    
    @IBOutlet weak var weeklyCollectionview: UICollectionView!
    
    var colourArray: [UIColor] = [.black,.blue,.red,.brown,.cyan,.green,.orange,.black,.blue,.red,.brown,.cyan,.green,.orange,.black,.blue,.red,.brown,.cyan,.green,.orange,.black,.blue,.red,.brown,.cyan,.green,.orange,.black,.blue,.red,.brown,.cyan,.green,.orange,.black,.blue,.red,.brown,.cyan,.green,.orange,.black,.blue,.red,.brown,.cyan,.green,.orange,.black,.blue,.red,.brown,.cyan,.green,.orange,.black,.blue,.red,.brown,.cyan,.green,.orange,.black,.blue,.red,.brown,.cyan,.green,.orange,.black,.blue,.red,.brown,.cyan,.green,.orange]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupcollectionViews()
    }
    
    private func setupcollectionViews() {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeeklyCell", for: indexPath) as? CalendarCell {
            cell.backgroundColor = colourArray[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: weeklyCollectionview.frame.width/3, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

