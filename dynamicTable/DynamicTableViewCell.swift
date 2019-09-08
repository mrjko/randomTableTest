//
//  DynamicTableView.swift
//  dynamicTable
//
//  Created by Jimmy Ko on 2019-09-08.
//  Copyright © 2019 Jimmy Ko. All rights reserved.
//

import UIKit

class DynamicTableViewCell: UITableViewCell {
    
    private var contentStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpContentStackView()
        print("init")
        print("frame width: \(self.frame.width)")
        print("bounds width: \(self.bounds.width)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpContentStackView() {
        self.contentStackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentStackView.axis = .horizontal
        self.contentStackView.distribution = .fill
        self.contentStackView.alignment = .leading
        
        self.contentView.addSubview(contentStackView)
        self.fillSuperview(view: contentStackView)
    }
    
    
    /// Description: Set-up the custom cell base on given column name and ratio
    ///
    /// - Parameters:
    ///   - columns: the value to put into each column
    ///   - ratios: the width ratio each column should be relative to total size
    public func setUpCustomCell(columns: [String], ratios: [Double]) {
        
        // TODO: bounds check for both (if they're the same..etc)
        
        for idx in 0..<columns.count {
            let columnView = UIView()
            columnView.translatesAutoresizingMaskIntoConstraints = false
            columnView.layer.borderColor = UIColor.darkGray.cgColor
            columnView.layer.borderWidth = 1
            
            let columnData = UILabel()
            columnData.translatesAutoresizingMaskIntoConstraints = false
            columnData.textAlignment = .center
            columnData.text = columns[idx]
            
            columnView.addSubview(columnData)
            fillSuperview(view: columnData)
            
            // TODO: ratio validation check
            
            self.contentStackView.addArrangedSubview(columnView)
            addToStackViewWithRatio(columnView, ratio: ratios[idx])
        }
        
    }
    
    // helper func (extension)
    private func fillSuperview(view: UIView) {
        guard let superview = view.superview else {
            print("attempting to fill to superview without a superview.")
            return
        }
        
        view.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: superview.heightAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: superview.widthAnchor).isActive = true
    }
    
    private func addToStackViewWithRatio(_ view: UIView, ratio: Double) {
        view.topAnchor.constraint(equalTo: self.contentStackView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.contentStackView.bottomAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: self.contentStackView.heightAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: self.contentStackView.widthAnchor,
                                    multiplier: CGFloat(ratio)).isActive = true
    }
}
