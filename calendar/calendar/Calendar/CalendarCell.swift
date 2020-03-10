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
    var eventOneImage: UIImageView?
    var eventTwoImage: UIImageView?
    var eventThreeImage: UIImageView?
    var day: Day? {
        didSet {
            setupImages()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        backgroundColor = .systemBlue
        setupLabel()
        setupImages()
    }
    
    private func setupImages() {
        guard let day = day else {return}
        switch day.events?.count {
        case 0:
            break
        case 1:
            setupEventOneImage()
        case 2:
            setupEventTwoImage()
        default:
            setupEventThreeImage()
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
    
    private func setupEventOneImage() {
        eventOneImage = UIImageView()
        guard let eventOneImage = eventOneImage else {return}
        eventOneImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(eventOneImage)
        getImage(imageView: eventOneImage, number: 1)
        NSLayoutConstraint.activate([
            eventOneImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            eventOneImage.centerXAnchor.constraint(equalTo: dateLabel.centerXAnchor),
            eventOneImage.heightAnchor.constraint(equalToConstant: frame.height/6),
            eventOneImage.widthAnchor.constraint(equalToConstant: frame.height/6)
        ])
    }
    
    private func setupEventTwoImage() {
        setupEventOneImage()
        eventTwoImage = UIImageView()
        guard let eventOneImage = eventOneImage, let eventTwoImage = eventTwoImage else {return}
        eventTwoImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(eventTwoImage)
        getImage(imageView: eventTwoImage, number: 2)
        NSLayoutConstraint.activate([
            eventTwoImage.topAnchor.constraint(equalTo: eventOneImage.bottomAnchor, constant: 5),
            eventTwoImage.centerXAnchor.constraint(equalTo: eventOneImage.centerXAnchor),
            eventTwoImage.heightAnchor.constraint(equalToConstant: frame.height/6),
            eventTwoImage.widthAnchor.constraint(equalToConstant: frame.height/6)
        ])
    }

    private func setupEventThreeImage() {
        setupEventTwoImage()
        eventThreeImage = UIImageView()
        guard let eventTwoImage = eventTwoImage, let eventThreeImage = eventThreeImage else {return}
        eventThreeImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(eventThreeImage)
        getImage(imageView: eventThreeImage, number: 3)
        NSLayoutConstraint.activate([
            eventThreeImage.topAnchor.constraint(equalTo: eventTwoImage.bottomAnchor, constant: 5),
            eventThreeImage.centerXAnchor.constraint(equalTo: eventTwoImage.centerXAnchor),
            eventThreeImage.heightAnchor.constraint(equalToConstant: frame.height/6),
            eventThreeImage.widthAnchor.constraint(equalToConstant: frame.height/6),
        ])
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
        eventOneImage = nil
        eventTwoImage = nil
        eventThreeImage = nil
        day = nil
    }
    
}
