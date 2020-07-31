//
//  DailySectionHeaderView.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/03.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

protocol DailySectionHeaderViewDelegate: class {
    func didTapPlusButton(section: Int)
}

class DailySectionHeaderView: UIView {
    weak var delegate: DailySectionHeaderViewDelegate?
    
    var section = 0
    
    // MARK: -Property
    let foodLabel = UILabel()
    let seperator = UIView()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        let plusImage = UIImage(systemName: "plus")
        button.tintColor = .white
        button.setImage(plusImage, for: .normal)
        button.setPreferredSymbolConfiguration(.init(scale: .default), forImageIn: .normal)
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: -init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = ColorZip.purple
        setUI()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapPlusButton(_ sender: UIButton) {
        delegate?.didTapPlusButton(section: section)
    }
    
    // MARK: - setup
    private func setUI() {
        [foodLabel, plusButton, seperator].forEach {
            self.addSubview($0)
        }
        
        foodLabel.textColor = .white
        foodLabel.font = .systemFont(ofSize: 16, weight: .light)
        seperator.backgroundColor = ColorZip.lightGray

    }
    
    private func setConstraint() {
        foodLabel.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(CGFloat.dynamicXMargin(margin: 25))
            $0.centerY.equalTo(self.snp.centerY)
        }
        
        plusButton.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.trailing).offset(CGFloat.dynamicXMargin(margin: -20))
            $0.centerY.equalTo(self.snp.centerY)
        }
        
        seperator.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom)
            $0.width.equalTo(self.snp.width)
            $0.leading.equalTo(self.snp.leading)
        }
    }
}


