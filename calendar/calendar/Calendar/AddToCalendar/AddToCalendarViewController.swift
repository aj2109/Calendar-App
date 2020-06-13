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
    @IBOutlet weak var descriptField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var important: UISwitch!
    
    
    @IBAction func okButtonPressed(_ sender: Any) {
        if let calendar = parent as? CalendarViewController {
            let dayDescription = NSEntityDescription.entity(forEntityName: "Event", in: CoreDataManager.shared.getContext())!
            let event = Event(entity: dayDescription, insertInto: CoreDataManager.shared.getContext())
            if let titleFieldText = titleField.text {
                event.title = titleFieldText
            }
            if let descriptFieldText = descriptField.text {
                event.descript = descriptFieldText
            }
            event.important = important.isOn
            do {
                calendar.addEvent(event: event)
                try CoreDataManager.shared.getContext().save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            hideEventEntry(calendar: calendar)
        }
    }
    
    func hideEventEntry(calendar: CalendarViewController) {
        calendar.blockerView.alpha = 0
        self.view.alpha = 0
        titleField.text = ""
        descriptField.text = ""
        titleField.resignFirstResponder()
        descriptField.resignFirstResponder()
        important.isOn = true
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
