//
//  DateCell.swift
//  ScrollDatePicker
//
//  Created by Patrick Löber on 25.12.18.
//  Copyright © 2018 Patrick Loeber. All rights reserved.
//

import UIKit

class DateCell: UICollectionViewCell {
    
    let dateFormatter = DateFormatter()
    
    static let selectedBackgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
    static let selectedBackgroundViewColor = UIColor.blue
    
    var date: Date? {
        didSet {
            guard let date = date else { return }
            setDateLabel(for: date)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            selectedBottomView.alpha = isSelected ? 1 : 0
            selectedBgView.alpha = isSelected ? 1 : 0
        }
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectedBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = selectedBackgroundViewColor
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let selectedBgView: UIView = {
        let view = UIView()
        view.backgroundColor = selectedBackgroundColor
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        addSubview(selectedBgView)
        selectedBgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        selectedBgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        selectedBgView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        selectedBgView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(selectedBottomView)
        selectedBottomView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        selectedBottomView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        selectedBottomView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        selectedBottomView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        let columnStack = UIStackView(arrangedSubviews: [dateLabel, dayLabel])
        columnStack.axis = .horizontal
        columnStack.distribution = .equalCentering
        columnStack.alignment = .firstBaseline

        let rowStack = UIStackView(arrangedSubviews: [columnStack, monthLabel])
        rowStack.axis = .vertical
        rowStack.distribution = .equalSpacing
        rowStack.alignment = .center
        rowStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(rowStack)
        rowStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        rowStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        rowStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        rowStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    private func setDateLabel(for date: Date) {
        dateFormatter.dateFormat = "dd"
        dateLabel.text = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "EEE"
        dayLabel.text = dateFormatter.string(from: date).uppercased()
        
        dateFormatter.dateFormat = "MMMM"
        monthLabel.text = dateFormatter.string(from: date).uppercased()
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
