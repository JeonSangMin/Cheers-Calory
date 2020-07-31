//
//  RecommendedBodyView.swift
//  Cheers!Calory!
//
//  Created by 은영김 on 2020/06/09.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class RecommendedBodyView: UIView {

  // MARK: -Property
  private let puppleLine1 = UIView()
  private let puppleLine2 = UIView()
  private let averageWeight = UILabel()
  private let averageWeightLabel = UILabel()
  private let recommendedCalories = UILabel()
  private let recommendedCaloriesLabel = UILabel()

  
  // MARK: -init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
  }
   
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: -Action
  
  func configue(weight: String, calories: String) {
    averageWeight.text = "내 키의 적정몸무게"
    averageWeightLabel.text = "  \(weight)kg  "
    recommendedCalories.text = "일일권장섭취량"
    recommendedCaloriesLabel.text = " \(calories)kcal "
    
//    My Daily Recommended Calories
//    My average weight
  }
  
  // MARK: -setupUI
  
  private func setupUI() {
    self.addSubviews([
    puppleLine1,
    puppleLine2,
    averageWeight,
    averageWeightLabel,
    recommendedCalories,
    recommendedCaloriesLabel
    ])
    
    [puppleLine1, puppleLine2,].forEach {
      $0.backgroundColor = ColorZip.purple
//      $0.backgroundColor = .white
    }
    [averageWeight, recommendedCalories].forEach {
      $0.font = .systemFont(ofSize: 22, weight: .regular)
      $0.textColor = ColorZip.purple
    }
    [averageWeightLabel, recommendedCaloriesLabel].forEach {
      $0.font = .systemFont(ofSize: 24, weight: .regular)
      $0.textColor = ColorZip.purple
    }
    setupConstraint()
  }
  
  // MARK: -setupConstraint
  
  private func setupConstraint() {
    
    puppleLine1.snp.makeConstraints {
      $0.top.equalToSuperview().offset(CGFloat.dynamicXMargin(margin: 86))
      $0.height.equalTo(CGFloat.dynamicYMargin(margin: 1.6))
      $0.width.equalToSuperview().multipliedBy(0.86)
      $0.trailing.equalToSuperview()
    }
    
    puppleLine2.snp.makeConstraints {
      $0.top.equalTo(puppleLine1.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 86))
      $0.height.equalTo(CGFloat.dynamicYMargin(margin: 1.6))
      $0.width.equalToSuperview().multipliedBy(0.86)
      $0.trailing.equalToSuperview()
    }
    
    averageWeight.snp.makeConstraints {
      $0.bottom.equalTo(puppleLine1.snp.top).offset(CGFloat.dynamicYMargin(margin: -10))
      $0.leading.equalTo(puppleLine1.snp.leading)
    }

    averageWeightLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(CGFloat.dynamicXMargin(margin: -14))
      $0.top.equalTo(averageWeight)
    }
    
    recommendedCalories.snp.makeConstraints {
      $0.bottom.equalTo(puppleLine2.snp.top).offset(CGFloat.dynamicYMargin(margin: -10))
      $0.leading.equalTo(puppleLine2.snp.leading)
    }
    
    recommendedCaloriesLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(CGFloat.dynamicXMargin(margin: -14))
      $0.top.equalTo(recommendedCalories)
    }
    
  }
  

}
