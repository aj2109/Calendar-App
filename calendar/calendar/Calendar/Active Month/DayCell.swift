//
//  CalendarCell.swift
//  calendar
//
//  Created by Adam Jessop on 06/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    
    var dateLabel = UILabel()
    var eventImages: [UIImageView] = []
    var day: Day? {
        didSet {
            setupImages()
        }
    }
    
    func setupCell() {
        selectedBackgroundView = UIView(frame: frame)
        selectedBackgroundView?.backgroundColor = .purple
        selectedBackgroundView?.layer.cornerRadius = 7.5
        layer.cornerRadius = 7.5
        setupLabel()
        setupImages()
        backgroundColor = isSelected ? .purple : .systemBlue
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
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: frame.height/2),
            dateLabel.widthAnchor.constraint(equalToConstant: frame.width)
        ])
    }
    
    private func setupEventImages(eventCount: Int) {
        for index in 0..<eventCount {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)
            getImage(imageView: imageView, number: index)
            if index == 0 {
                dateLabel.translatesAutoresizingMaskIntoConstraints = false
                addSubview(dateLabel)
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
                    imageView.centerXAnchor.constraint(equalTo: dateLabel.centerXAnchor),
                    imageView.heightAnchor.constraint(equalToConstant: frame.height/10),
                    imageView.widthAnchor.constraint(equalToConstant: frame.height/10)
                ])
            } else {
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: eventImages[index-1].bottomAnchor, constant: 5),
                    imageView.centerXAnchor.constraint(equalTo: eventImages[index-1].centerXAnchor),
                    imageView.heightAnchor.constraint(equalToConstant: frame.height/10),
                    imageView.widthAnchor.constraint(equalToConstant: frame.height/10)
                ])
            }
            eventImages.append(imageView)
        }
    }
    
    private func getImage(imageView: UIImageView, number: Int) {
        guard let day = day, let event = day.events?.allObjects[number] as? Event else {return}
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
        eventImages = []
        day = nil
        dateLabel.text = nil
        dateLabel = UILabel()
    }
    
}
