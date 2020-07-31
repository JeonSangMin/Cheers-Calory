//
//  ReportsTableViewCell.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/29.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class ReportsTableViewCell: UITableViewCell {
    static let identifier = "reportsCell"
    
    let dateLabel = UILabel()
    let caloryLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        [dateLabel, caloryLabel].forEach {
            self.addSubview($0)
        }
        dateLabel.font = UIFont.dynamicFont(fontSize: 16, weight: .ultraLight)
        caloryLabel.font = UIFont.dynamicFont(fontSize: 16, weight: .medium)
        
        dateLabel.textColor = .gray
        caloryLabel.textColor = .black
        
        setConstraints()
    }
    
    private func setConstraints() {
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(CGFloat.dynamicXMargin(margin: 20))
            $0.centerY.equalTo(self.snp.centerY)
        }
        
        caloryLabel.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.trailing).offset(CGFloat.dynamicXMargin(margin: -24))
            $0.centerY.equalTo(self.snp.centerY)
        }
    }

}
