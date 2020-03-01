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
    
    
    override func viewDidLoad() {
        if let name = UserDefaults.standard.value(forKey: "NameChoice") as? String, let imageIndex = UserDefaults.standard.value(forKey: "ImageChoice") as? Int {
            username.text = "Hi \(name)!"
            avatar.image = SetupViewController.avatarImages[imageIndex]
        }
    }
    
}
