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
    static var avatarImages: [UIImage] = [#imageLiteral(resourceName: "man-2"),#imageLiteral(resourceName: "man-1"),#imageLiteral(resourceName: "man"),#imageLiteral(resourceName: "boy"),#imageLiteral(resourceName: "girl-1"),#imageLiteral(resourceName: "girl")]
    
    @IBOutlet weak var displayName: UITextField!
    
    @IBOutlet weak var avatarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayName.delegate = self
    }
    
    private func presentHomeVC() {
        DispatchQueue.main.async {
            let homeSectionsViewController = HomeSectionPagingViewController()
            self.navigationController?.pushViewController(homeSectionsViewController, animated: true)
        }
    }
    
    @IBAction func chooseAnAvatar(_ sender: Any) {
        if displayName.text?.count == 0, displayName.text != " " {
            let alert = UIAlertController(title: "Enter a username", message: "Please enter a username before selecting an avatar", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return
        }
        avatarButton.isSelected = !avatarButton.isSelected
        if avatarButton.isSelected {
            let collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: 100, height: 100)
            collectionViewFlowLayout.minimumLineSpacing = 25
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 20, left: 50, bottom: 50, right: 50)
            avatarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
            guard let avatarCollectionView = avatarCollectionView else {return}
            avatarCollectionView.register(AvatarCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
            avatarCollectionView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(avatarCollectionView)
            if UIScreen.main.traitCollection.userInterfaceIdiom == .pad {
                NSLayoutConstraint.activate([
                    avatarCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    avatarCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    avatarCollectionView.heightAnchor.constraint(equalToConstant: 400),
                    avatarCollectionView.widthAnchor.constraint(equalToConstant: 600)
                ])
            } else {
                NSLayoutConstraint.activate([
                    avatarCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    avatarCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                    avatarCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                    avatarCollectionView.heightAnchor.constraint(equalToConstant: 400)
                ])
            }
            avatarCollectionView.delegate = self
            avatarCollectionView.dataSource = self
            avatarCollectionView.alpha = 1
        } else {
            avatarCollectionView?.alpha = 0
        }
    }
    
}

extension SetupViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDefaults.standard.set(displayName.text, forKey: "NameChoice")
        UserDefaults.standard.set(indexPath.row, forKey: "ImageChoice")
        presentHomeVC() 
    }
    
}

extension SetupViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        SetupViewController.avatarImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? AvatarCollectionViewCell {
            cell.imageView.image = SetupViewController.avatarImages[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
}

extension SetupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

