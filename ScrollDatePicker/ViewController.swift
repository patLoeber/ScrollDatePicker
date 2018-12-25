//
//  ViewController.swift
//  ScrollDatePicker
//
//  Created by Patrick Löber on 25.12.18.
//  Copyright © 2018 Patrick Loeber. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var collectionView: UICollectionView!
    
    private let backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    
    var dates = [Date]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = self.backgroundColor
        setupCollectionView()
        self.dates = getNextDays(count: 30)
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }
    
    private func setupCollectionView() {
        let height: CGFloat = 50
        let width: CGFloat = 80
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: DateCell.identifier)
        
        view.addSubview(collectionView)
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
    }
    
    private func getNextDays(count: Int) -> [Date] {
        var dates = [Date]()
        for day in 0..<count {
            dates.append(Date(timeIntervalSinceNow: Double(day * 86400)))
        }
        return dates
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCell.identifier, for: indexPath) as! DateCell
        let date = dates[indexPath.item]
        cell.date = date
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

