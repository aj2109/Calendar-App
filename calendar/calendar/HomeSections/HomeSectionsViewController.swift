//
//  HomeSectionsViewController.swift
//  calendar
//
//  Created by Adam Jessop on 29/02/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit

class HomeSectionsViewController: UIViewController {
    
    var sections = [TodaySectionViewController(), UpcomingEventsViewController(), CalendarViewController(), SettingsViewController()]
    
    var pagingViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    var pageControl = UIPageControl()
    
    var index = 0
    
    override func viewDidLoad() {
        setupPageControl()
        setupPager()
    }
    
    private func setupPageControl() {
        let pageControl = UIPageControl()
        view.addSubview(pageControl)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pageControl.widthAnchor.constraint(equalToConstant: 100),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        pageControl.numberOfPages = sections.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .blue
    }
    
    private func setupPager() {
//        guard let pagingView = pagingViewController.view else {return}
//        addChild(pagingViewController)
//        view.addSubview(pagingView)
//        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            pagingView.topAnchor.constraint(equalTo: view.topAnchor),
//            pagingView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20),
//            pagingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            pagingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//        pagingViewController.dataSource = self
//        pagingViewController.delegate = self
//        if let firstViewController = sections.first {
//            pagingViewController.setViewControllers([firstViewController],
//                                                    direction: .forward,
//                                                    animated: true,
//                                                    completion: nil)
//        }
    }
    
}

extension HomeSectionsViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, finished, let currentVC = pageViewController.viewControllers?.last, let currentIndex = sections.firstIndex(of: currentVC) {
            index = currentIndex
        }
    }
    
}

extension HomeSectionsViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard index > 0 else {return nil}
        pageControl.currentPage = index
        pageControl.updateCurrentPageDisplay()
        return sections[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard index + 1 < sections.count else {return nil}
        pageControl.currentPage = index
        pageControl.updateCurrentPageDisplay()
        return sections[index + 1]
    }
    
}
