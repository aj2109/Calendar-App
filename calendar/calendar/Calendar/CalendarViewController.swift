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
    
    @IBOutlet weak var monthsCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewContainer: UIView!
    @IBOutlet weak var addEventButton: UIButton!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var previousMonthButton: UIButton!
    @IBOutlet weak var nextMonthButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedDayIndex: Int?
    
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideEventCreator(_ :)))
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
        setupDates()
        setupImages()
        setupText()
        setupDelegates()
    }
    
    private func setupImages() {
        nextMonthButton.imageView?.image = nextMonthButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        nextMonthButton.imageView?.image?.withTintColor(.white)
        previousMonthButton.imageView?.image = previousMonthButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        previousMonthButton.imageView?.image?.withTintColor(.white)
    }
    
    private func setupDates() {
        CoreDataManager.shared.setupData()
        let yearAndMonth = DateManager.getCurrentYearAndMonthObject()
        CalendarDataManager.shared.currentYear = yearAndMonth.0
        CalendarDataManager.shared.currentMonth = yearAndMonth.1
        DateManager.currentDate = Date()
    }
    
    private func setupText() {
        monthLabel.text = "\(CalendarDataManager.shared.currentMonth.name) \(CalendarDataManager.shared.currentYear.number)"
    }
    
    private func setupDelegates() {
       tableView.delegate = CalendarDataManager.shared.activeDayDelegateDataSource
       tableView.dataSource = CalendarDataManager.shared.activeDayDelegateDataSource
       monthsCollectionView.delegate = CalendarDataManager.shared.monthsDelegate
       monthsCollectionView.dataSource = CalendarDataManager.shared.monthsDataSource
    }
    
    func addEvent(event: Event) {
        if let currentDay = CalendarDataManager.shared.currentDay {
            if DateManager.checkIfToday(day: currentDay) {
                CoreDataManager.shared.today?.addToEvents(event)
            }
            currentDay.addToEvents(event)
        }
        tableView.reloadData()
        //selectedMonthCollectionView.reloadData()
    }
    
    private func clearAllSelected() {
//        for number in 0..<selectedMonthCollectionView.numberOfItems(inSection: 0) {
//            selectedDayIndex = nil
//            selectedMonthCollectionView.cellForItem(at: IndexPath(row: number, section: 0))?.backgroundColor = .systemBlue
//        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        clearAllSelected()
    }
    
    @IBAction func previousMonthPressed(_ sender: Any) {
        let yearAndMonth = DateManager.getPreviousYearAndMonthObject(currentYear: CalendarDataManager.shared.currentYear, currentMonth: CalendarDataManager.shared.currentMonth)
        CalendarDataManager.shared.currentYear = yearAndMonth.0
        CalendarDataManager.shared.currentMonth = yearAndMonth.1
        monthLabel.text = "\(CalendarDataManager.shared.currentMonth.name) \(CalendarDataManager.shared.currentYear.number) "
        selectedDayIndex = nil
        //selectedMonthCollectionView.reloadData()
    }
    
    @IBAction func nextMonthPressed(_ sender: Any) {
        let yearAndMonth = DateManager.getNextYearAndMonthObject(currentYear: CalendarDataManager.shared.currentYear, currentMonth: CalendarDataManager.shared.currentMonth)
        CalendarDataManager.shared.currentYear = yearAndMonth.0
        CalendarDataManager.shared.currentMonth = yearAndMonth.1
        monthLabel.text = "\(CalendarDataManager.shared.currentMonth.name) \(CalendarDataManager.shared.currentYear.number) "
        selectedDayIndex = nil
        //selectedMonthCollectionView.reloadData()
    }
    
    @IBAction func addEvent(_ sender: Any) {
        blockerView.alpha = 0.7
        eventSelectViewController.view.alpha = 1
    }
    
    @objc private func hideEventCreator(_ sender: UITapGestureRecognizer? = nil) {
        eventSelectViewController.hideEventEntry(calendar: self)
    }
    
}
