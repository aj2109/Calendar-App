//
//  SetupViewController.swift
//  calendar
//
//  Created by Adam Jessop on 29/02/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {
    
    var avatarCollectionView: UICollectionView?
    
    @IBOutlet weak var displayName: UITextField!
    
    @IBAction func chooseAnAvatar(_ sender: Any) {
        avatarCollectionView = UICollectionView()
        guard let avatarCollectionView = avatarCollectionView else {return}
        view.addSubview(avatarCollectionView)
        
        avatarCollectionView.delegate = self
        avatarCollectionView.dataSource = self
    }
    
}

extension SetupViewController: UICollectionViewDelegate {
    
}

extension SetupViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
