//
//  CalendarCell.swift
//  calendar
//
//  Created by Adam Jessop on 06/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    var dateLabel = UILabel()
    var eventImages: [UIImageView] = []
    var day: Day? {
        didSet {
            setupImages()
        }
    }
    
    func setupCell() {
        backgroundColor = .systemBlue
        selectedBackgroundView = UIView(frame: frame)
        selectedBackgroundView?.backgroundColor = .purple
        setupLabel()
        setupImages()
    }
    
    private func setupImages() {
        guard let day = day else {return}
        switch day.events?.count {
        case 0:
            break
        case 1:
            setupEventImages(eventCount: 1)
        case 2:
            setupEventImages(eventCount: 2)
        default:
            setupEventImages(eventCount: 3)
        }
    }
    
    private func setupLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dateLabel)
        dateLabel.font = UIFont(name: "Rightland", size: 20)
        dateLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: frame.height/2),
            dateLabel.widthAnchor.constraint(equalToConstant: frame.width)
        ])
    }
    
    private func setupEventImages(eventCount: Int) {
        for _ in 0..<eventCount {
            let imageView = UIImageView()
            eventImages.append(imageView)
        }
        for (index, imageView) in eventImages.enumerated() {
            var topAnchorView = UIView()
            if index == 0 {
                topAnchorView = dateLabel
            } else {
                topAnchorView = eventImages[index-1]
            }
            imageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)
            getImage(imageView: imageView, number: index)
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchorView.bottomAnchor, constant: 5),
                imageView.centerXAnchor.constraint(equalTo: topAnchorView.centerXAnchor),
                imageView.heightAnchor.constraint(equalToConstant: frame.height/7),
                imageView.widthAnchor.constraint(equalToConstant: frame.height/7)
            ])
        }
    }
    
    private func getImage(imageView: UIImageView, number: Int) {
        guard let day = day, let event = day.events?.allObjects[number - 1] as? Event else {return}
        if event.important {
            imageView.image = #imageLiteral(resourceName: "exclamation-mark")
        } else {
            imageView.image = #imageLiteral(resourceName: "tick")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = .systemBlue
        eventImages.forEach({$0.image = nil})
        day = nil
    }
    
}
