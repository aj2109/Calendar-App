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
            vc.view.heightAnchor.constraint(equalToConstant: 375),
            vc.view.widthAnchor.constraint(equalToConstant: 600)
        ])
        vc.view.layer.cornerRadius = 5
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupText()
        setupDelegates()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name("reloadTable"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dateChanged), name: NSNotification.Name("dateChanged"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupText() {
        if let dayObject = CalendarDataManager.shared.currentDay {
            monthLabel.text = "\(dayObject.dateNumber) \(dayObject.month.name)"
        }
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
       reloadTable()
       reloadActiveDayCell()
    }
    
    @objc private func reloadTable() {
        tableView.reloadData()
        setupText()
    }
    
    @objc private func dateChanged() {
        setupText()
    }
    
    private func reloadActiveDayCell() {
        monthsCollectionView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func addEvent(_ sender: Any) {
        blockerView.alpha = 0.7
        eventSelectViewController.view.alpha = 1
    }
    
    @objc private func hideEventCreator(_ sender: UITapGestureRecognizer? = nil) {
        eventSelectViewController.hideEventEntry(calendar: self)
    }
    
}
