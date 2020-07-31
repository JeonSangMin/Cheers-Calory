//
//  FoodDetailViewController.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController {
    var dailyIntakeDetail: Food?
    
    init(detail: Food) {
        self.dailyIntakeDetail = detail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let foodTitle = UILabel()
    private let servingSize = UILabel()
    private let protein = UILabel()
    private let fat = UILabel()
    private let carbohydrate = UILabel()
    private let totalCal = UILabel()
    
    private let servingSizeLabel = UILabel()
    private let proteinLabel = UILabel()
    private let fatLabel = UILabel()
    private let carbohydrateLabel = UILabel()
    private let totalCalLabel = UILabel()
    
    private let circleView = UIView()
    private let seperator = UIView()
    private let checkButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillLayoutSubviews() {
        self.view.layer.cornerRadius = 10
        
        guard let tabbar = self.presentingViewController as? UITabBarController else { return print("탭바 없음")}
        guard let navi = tabbar.viewControllers?[1] as? UINavigationController else { return print("네비게이션 없음")}
        guard let dailyVC = navi.viewControllers.first as? DailyViewController else { return print("데일리 없음")}
        
        self.view.snp.makeConstraints {
            $0.center.equalTo(dailyVC.view.safeAreaLayoutGuide.snp.center)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.33)
        }
        
        circleView.layer.cornerRadius = circleView.frame.width / 2
        checkButton.layer.addBorder([.top], color: ColorZip.lightGray, width: 0.5)
    }
    
    // 델리게이트 패턴으로 레이블 타이틀 전달해줄것
    private func setUI() {
        view.backgroundColor = ColorZip.alert
        setLabelText()
        setConstraints()
    }
    
    private func setLabelText() {
        [foodTitle, totalCal, totalCalLabel, circleView, checkButton].forEach {
            view.addSubview($0)
        }
        
        [servingSizeLabel, proteinLabel, fatLabel, carbohydrateLabel].forEach {
            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalTo(view.snp.centerX)
            }
            $0.font = UIFont.dynamicFont(fontSize: 15, weight: .ultraLight)
        }
        
        [totalCal, totalCalLabel].forEach {
            circleView.addSubview($0)
        }
        
        foodTitle.text = dailyIntakeDetail?.foodName
        foodTitle.font = UIFont.dynamicFont(fontSize: 18, weight: .bold)
        totalCal.text = dailyIntakeDetail?.calory
        totalCal.font = UIFont.dynamicFont(fontSize: 40, weight: .bold)
        servingSize.text = dailyIntakeDetail?.servingSize
        protein.text = dailyIntakeDetail?.protein
        fat.text = dailyIntakeDetail?.fat
        carbohydrate.text = dailyIntakeDetail?.carbohydrate
        
        circleView.backgroundColor = .clear
        circleView.layer.borderWidth = 4
        circleView.layer.borderColor = ColorZip.purple.cgColor
        
        if let detail = dailyIntakeDetail {
            servingSizeLabel.text = "섭취량 \(detail.servingSize)g"
            proteinLabel.text = "단백질 \(detail.protein)g"
            fatLabel.text = "지방 \(detail.fat)g"
            carbohydrateLabel.text = "탄수화물 \(detail.carbohydrate)g"
        }
        totalCalLabel.text = "kcal"
        totalCalLabel.textColor = UIColor.lightGray
        
        checkButton.setTitle("확인", for: .normal)
        checkButton.setTitleColor(.systemBlue, for: .normal)
        checkButton.addTarget(self, action: #selector(didTapCheckButton(_:)), for: .touchUpInside)
    }
    
    private func setConstraints() {
        let yMargin = CGFloat.dynamicYMargin(margin: 10)
        
        foodTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(yMargin * 2)
        }
        
        servingSizeLabel.snp.makeConstraints {
            $0.bottom.equalTo(proteinLabel.snp.top).offset(-yMargin)
        }
        
        proteinLabel.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.centerY).offset(CGFloat.dynamicYMargin(margin: -5))
        }
        
        fatLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.centerY).offset(CGFloat.dynamicYMargin(margin: 5))
        }
        
        carbohydrateLabel.snp.makeConstraints {
            $0.top.equalTo(fatLabel.snp.bottom).offset(yMargin)
        }
        
        circleView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(view.snp.centerX).offset(-yMargin)
            $0.width.height.equalTo(view.snp.height).multipliedBy(0.5)
        }
        
        totalCal.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        totalCalLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(totalCal.snp.bottom)
        }
        
        checkButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.2)
            $0.width.equalToSuperview()
        }
    }
    
    @objc private func didTapCheckButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
