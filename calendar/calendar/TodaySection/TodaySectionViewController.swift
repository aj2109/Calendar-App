//
//  TodaySectionViewController.swift
//  calendar
//
//  Created by Adam Jessop on 29/02/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit

class TodaySectionViewController: UIViewController {
    
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        if let name = UserDefaults.standard.value(forKey: "NameChoice") as? String, let imageIndex = UserDefaults.standard.value(forKey: "ImageChoice") as? Int {
            username.text = "Hi \(name)!"
            avatar.image = SetupViewController.avatarImages[imageIndex]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
}

extension TodaySectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.today?.events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarEventsCell", for: indexPath) as? CalendarEventsCell,
            let event = CoreDataManager.shared.today?.events?.allObjects[indexPath.row] as? Event {
            cell.textLabel?.text = event.title
            cell.detailTextLabel?.text = event.descript
            return cell
        }
        return UITableViewCell()
    }

}
