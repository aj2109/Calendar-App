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

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var addEventButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var previousMonthButton: UIButton!
    @IBOutlet weak var nextMonthButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var currentYear: Year!
    var currentMonth: Month!
    var currentDay: Day?
    var selectedIndex: Int?
    
    lazy var blockerView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideEventAdder(_ :)))
        blurView.contentView.addGestureRecognizer(tap)
        return blurView
    }()
    
    lazy var eventSelectViewController: AddToCalendarViewController = {
        guard let sb = UIStoryboard(name: "CalendarViewController", bundle: .main) as UIStoryboard?,
            let vc = sb.instantiateViewController(identifier: "AddToCalendar") as? AddToCalendarViewController else {
                return AddToCalendarViewController()
        }
        addChild(vc)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vc.view)
        NSLayoutConstraint.activate([
            vc.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vc.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vc.view.heightAnchor.constraint(equalToConstant: 300),
            vc.view.widthAnchor.constraint(equalToConstant: 400)
        ])
        vc.view.layer.cornerRadius = 5
        return vc
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.shared.setupData()
        let yearAndMonth = DateManager.getCurrentYearAndMonthObject()
        currentYear = yearAndMonth.0
        currentMonth = yearAndMonth.1
        DateManager.currentDate = Date()
        monthLabel.text = "\(currentMonth.name) \(currentYear.number)"
        nextMonthButton.imageView?.image = nextMonthButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        nextMonthButton.imageView?.image?.withTintColor(.white)
        previousMonthButton.imageView?.image = previousMonthButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        previousMonthButton.imageView?.image?.withTintColor(.white)
    }
    
    func addEvent(event: Event) {
        if let currentDay = currentDay {
            currentDay.addToEvents(event)
        }
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    private func clearAllSelected() {
        for number in 0..<collectionView.numberOfItems(inSection: 0) {
            selectedIndex = nil
            collectionView.cellForItem(at: IndexPath(row: number, section: 0))?.backgroundColor = .systemBlue
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        clearAllSelected()
    }
    
    @IBAction func previousMonthPressed(_ sender: Any) {
        let yearAndMonth = DateManager.getPreviousYearAndMonthObject(currentYear: currentYear, currentMonth: currentMonth)
        currentYear = yearAndMonth.0
        currentMonth = yearAndMonth.1
        monthLabel.text = "\(currentMonth.name) \(currentYear.number) "
        selectedIndex = nil
        collectionView.reloadData()
    }
    
    @IBAction func nextMonthPressed(_ sender: Any) {
        let yearAndMonth = DateManager.getNextYearAndMonthObject(currentYear: currentYear, currentMonth: currentMonth)
        currentYear = yearAndMonth.0
        currentMonth = yearAndMonth.1
        monthLabel.text = "\(currentMonth.name) \(currentYear.number) "
        selectedIndex = nil
        collectionView.reloadData()
    }
    
    @IBAction func addEvent(_ sender: Any) {
        blockerView.alpha = 0.7
        eventSelectViewController.view.alpha = 1
    }
    
    @objc private func hideEventAdder(_ sender: UITapGestureRecognizer? = nil) {
        eventSelectViewController.hideEventEntry(calendar: self)
    }
    
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentMonth.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CalendarCell {
            if let _ = selectedIndex, indexPath.row == selectedIndex {
                cell.backgroundColor = .purple
            }
            cell.dateLabel.text = "\(indexPath.row + 1)"
            if let day = currentMonth?.days.allObjects[indexPath.row] as? Day, let events = day.events {
                cell.day = day

            }
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
        if let _ = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CalendarCell, let day = currentMonth.days.allObjects[indexPath.row] as? Day {
            selectedIndex = indexPath.row
            self.currentDay = day
            addEventButton.alpha = 1
            collectionView.reloadData()
            tableView.reloadData()
        }
    }
    
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDay?.events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarEventsCell", for: indexPath) as? CalendarEventsCell,
            let event = currentDay?.events?.allObjects[indexPath.row] as? Event {
            cell.textLabel?.text = event.title
            cell.detailTextLabel?.text = event.descript
            return cell
        }
        return UITableViewCell()
    }

}
