//
//  ReportView.swift
//  Cheers!Calory!
//
//  Created by 은영김 on 2020/06/05.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class RecommendedMainView: UIView {
    
    // MARK: -Property
    private let mainView = UIView()
    private let mainLabel = UILabel()
    private let infoLabel = UILabel()
    private let ageLabel = UILabel()
    private let heightLabel = UILabel()
    private let weightLabel = UILabel()
    
    
    // MARK: -init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Action
    
    func configue(info: String,age: String, height: String, weight: String) {
        infoLabel.text = "\(info)'s Infomation"
        ageLabel.text = "\(age)세"
        heightLabel.text = "\(height)cm"
        weightLabel.text = "\(weight)kg"
        
        setFontSizeDifferent(label: ageLabel, replaceString: "세")
        setFontSizeDifferent(label: heightLabel, replaceString: "cm")
        setFontSizeDifferent(label: weightLabel, replaceString: "kg")
    }
    
    // MARK: -setupUI
    private func setupUI() {
        self.addSubview(mainView)
        mainView.addSubviews([
            mainLabel,
            infoLabel,
            ageLabel,
            heightLabel,
            weightLabel,
        ])
        
        mainView.backgroundColor = ColorZip.purple
        mainLabel.text = "Cheers! Calory!"
        mainLabel.textColor = .white
        mainLabel.font = .systemFont(ofSize: 22, weight: .bold)
        
        infoLabel.textColor = .white
        infoLabel.font = .systemFont(ofSize: 14, weight: .regular)
        infoLabel.text = "길동's Infomation"
        ageLabel.text = "22"
        heightLabel.text = "168"
        weightLabel.text = "48"
        
        [ageLabel, heightLabel, weightLabel].forEach {
            $0.font = UIFont.dynamicFont(fontSize: 50, weight: .light)
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        setupConstraint()
    }
    
    // MARK: -setupConstraint
    
    private func setupConstraint() {
        let heightString = heightLabel.text!
        
        let guide = self.safeAreaLayoutGuide
        mainView.snp.makeConstraints {
            $0.top.trailing.leading.bottom.equalToSuperview()
        }
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(guide.snp.top)
            $0.centerX.equalToSuperview()
        }
        infoLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(CGFloat.dynamicXMargin(margin: 14))
            $0.top.equalTo(mainLabel.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 24))
        }
        heightLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(infoLabel.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 22))
            $0.height.equalTo((heightString as NSString).size(withAttributes: [NSAttributedString.Key.font: heightLabel.font!]).height)
        }
        
        ageLabel.snp.makeConstraints {
            $0.top.equalTo(heightLabel)
            $0.centerX.equalToSuperview().multipliedBy(0.4)
        }
        
        weightLabel.snp.makeConstraints {
            $0.top.equalTo(heightLabel)
            $0.centerX.equalToSuperview().multipliedBy(1.6)
        }
        
        
    }
    
    private func setFontSizeDifferent(label: UILabel, replaceString: String) {
        let fontSize = UIFont.dynamicFont(fontSize: 20, weight: .light)
        let attributedStr = NSMutableAttributedString(string: label.text!)
        attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: (label.text! as NSString).range(of: replaceString))
        label.attributedText = attributedStr
    }
    
}
