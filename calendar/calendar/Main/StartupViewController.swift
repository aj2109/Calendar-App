//
//  StartupViewController.swift
//  calendar
//
//  Created by Adam Jessop on 13/06/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit

class StartupViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = UserDefaults.standard.value(forKey: "NameChoice") {
            let homeSectionsViewController = HomeSectionPagingViewController()
            self.navigationController?.pushViewController(homeSectionsViewController, animated: false)
        } else {
            let setupViewController = SetupViewController()
            addChild(setupViewController)
            setupViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(setupViewController, animated: false)
        }
    }
    
}
