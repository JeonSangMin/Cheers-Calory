//
//  DailyHeaderView.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/03.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class DailyHeaderView: UIView {
    
    // MARK: -Property
    let label = UILabel()
    var totalCal = 0
    
    // MARK: -init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup
    private func setUI() {
        
        self.addSubview(label)
        label.font = .systemFont(ofSize: 30, weight: .bold)
        self.label.text = String(DailyIntakeDB.shared.todayIntake.totalCalory) + " kcal"
        
        label.textColor = .gray
        label.textAlignment = .center
        
        setConstraint()
    }
    
    private func setConstraint() {
        
        label.snp.makeConstraints {
            $0.centerY.centerX.equalTo(self)
        }
    }
}
