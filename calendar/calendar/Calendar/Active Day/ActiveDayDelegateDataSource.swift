//
//  ActiveDayDelegateDataSource.swift
//  calendar
//
//  Created by Adam Jessop on 11/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit

class ActiveDayDelegateDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CalendarDataManager.shared.currentDay?.events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarEventsCell", for: indexPath) as? CalendarEventsCell,
            let event = CalendarDataManager.shared.currentDay?.events?.allObjects[indexPath.row] as? Event {
            cell.textLabel?.text = event.title
            cell.detailTextLabel?.text = event.descript
            return cell
        }
        return UITableViewCell()
    }

}
