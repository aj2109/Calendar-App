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
            do {
                try CoreDataManager.shared.getContext().save()
                calendar.addEvent(event: event)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            hideEventEntry(calendar: calendar)
        }
    }
    
    private func hideEventEntry(calendar: CalendarViewController) {
        calendar.blockerView.alpha = 0
        self.view.alpha = 0
        titleField.text = ""
        descriptField.text = ""
        titleField.resignFirstResponder()
        descriptField.resignFirstResponder()
    }
    
}
