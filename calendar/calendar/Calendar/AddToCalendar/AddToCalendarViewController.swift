//
//  AddToCalendarViewController.swift
//  calendar
//
//  Created by Adam Jessop on 09/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit
import CoreData

class AddToCalendarViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var important: UISwitch!
    var timeFromDate: Date?
    var timeToDate: Date?
    var timeFromString: String?
    var timeToString: String?
    @IBOutlet weak var timeFromSelector: UIDatePicker!
    @IBOutlet weak var timeToSelector: UIDatePicker!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupDatesAndStrings()
    }
    
    private func setupDatesAndStrings() {
        setupDateObjects()
        setupDateStrings()
    }
    
    private func setupDateObjects() {
        setupFromDateObject()
        setupToDateObject()
    }
    
    private func setupDateStrings() {
        setupFromDateString()
        setupToDateString()
    }
    
    private func setupFromDateObject() {
        timeFromDate = DateManager.createFullDateFromCurrentDay(dateComponents: Foundation.Calendar.current.dateComponents([.hour, .minute], from: timeFromSelector.date))
    }
    
    private func setupToDateObject() {
        timeToDate = DateManager.createFullDateFromCurrentDay(dateComponents: Foundation.Calendar.current.dateComponents([.hour, .minute], from: timeToSelector.date))
    }
    
    private func setupFromDateString() {
        timeFromString = setupDateString(datePicker: timeFromSelector)

    }
    
    private func setupToDateString() {
        timeToString = setupDateString(datePicker: timeToSelector)
    }
    
    private func setupDateString(datePicker: UIDatePicker) -> String? {
        let time = Foundation.Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)
        if let hour = time.hour, let minute = time.minute {
            return  "\(hour):\(minute)"
        } else {
            return nil
        }
    }
    
    @IBAction func timeFromSelected(_ sender: UIDatePicker) {
        setupDatesAndStrings()
    }
    
    @IBAction func timeToSelected(_ sender: UIDatePicker) {
        setupDatesAndStrings()
    }
    
    
    @IBAction func okButtonPressed(_ sender: Any) {
        guard
            let timeFromString = timeFromString,
            let timeToString = timeToString,
            let timeFromDate = timeFromDate,
            let timeToDate = timeToDate,
            timeFromDate < timeToDate else {
                let alert = UIAlertController(title: "Invalid time", message: "Please make sure the 'to' time is later than the 'from' ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                return
        }
        if let calendar = parent as? CalendarViewController {
            let dayDescription = NSEntityDescription.entity(forEntityName: "Event", in: CoreDataManager.shared.getContext())!
            let event = Event(entity: dayDescription, insertInto: CoreDataManager.shared.getContext())
            if let titleFieldText = titleField.text {
                event.title = titleFieldText
                event.descript = "\(timeFromString)-\(timeToString)"
            }
            event.fromDate = timeFromDate
            event.toDate = timeToDate
            event.important = important.isOn
            do {
                calendar.addEvent(event: event)
                try CoreDataManager.shared.getContext().save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                hideEventEntry(calendar: calendar)
                return
            }
            DateManager.addToEKEventStore(event: event, completion: {
                self.hideEventEntry(calendar: calendar)
            })
        }
    }
    
    func hideEventEntry(calendar: CalendarViewController) {
        DispatchQueue.main.async {
            calendar.blockerView.alpha = 0
            self.view.alpha = 0
            self.titleField.text = ""
            self.titleField.resignFirstResponder()
            self.timeFromSelector.setDate(Date(), animated: false)
            self.timeToSelector.setDate(Date(), animated: false)
            self.important.isOn = true
        }
        timeFromDate = nil
        timeToDate = nil
        timeFromString = nil
        timeToString = nil
    }
    
    @IBAction func importantPressed(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "importantHelperShown") == false {
            let alertController = UIAlertController(title: "If your event is important keep this on!", message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            UserDefaults.standard.set(true, forKey: "importantHelperShown")
            self.present(alertController, animated: true)
        }
    }
}
