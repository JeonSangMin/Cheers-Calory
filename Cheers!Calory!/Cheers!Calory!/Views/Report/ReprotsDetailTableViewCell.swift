//
//  ReprotsDetailTableViewCell.swift
//  Cheers!Calory!
//
//  Created by 은영김 on 2020/07/01.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class ReprotsDetailTableViewCell: UITableViewCell {
  
  // MARK: -Identifier
  static let identifier = "ReprotsDetailTableViewCell"
  
  // MARK: -Property
  private let shadowView = UIView()
  private let titleLabel = UILabel()
  private let lineView = UIView()
  private let totalCalory = UILabel()
  private var leftStackView = UIStackView()
  private var rightStackView = UIStackView()
  
  // MARK: -init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setUI()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: -Action
  
  func configue(title: String, totalCalory: String) {
    self.titleLabel.text = title
    self.totalCalory.text = totalCalory
  }
  
  func configue(title: String, totalCalory: String, foods: [Food]) {
    self.titleLabel.text = title
    self.totalCalory.text = totalCalory

    leftStackView.removeAllArrangedSubviews()
    rightStackView.removeAllArrangedSubviews()
    foods.forEach {
      let foodName = UILabel()
      let calory = UILabel()
      foodName.textColor = ColorZip.purple
      calory.textColor = ColorZip.purple
      foodName.text = $0.foodName
      calory.text = $0.calory
      leftStackView.addArrangedSubview(foodName)
      rightStackView.addArrangedSubview(calory)
    }
  }
  // MARK: -setupUI
  
  private func setUI() {
    contentView.addSubviews([
      shadowView,
    ])
    
    shadowView.addSubviews([
      titleLabel,
      lineView,
      totalCalory,
      leftStackView,
      rightStackView
    ])
    
    shadowView.layer.shadowColor = UIColor.black.cgColor
    shadowView.layer.shadowOffset = .zero
    shadowView.layer.shadowOpacity = 0.2
    shadowView.layer.shadowRadius = 4.0
    shadowView.backgroundColor = ColorZip.lightGray3
    lineView.backgroundColor = ColorZip.purple
    
    [titleLabel, totalCalory].forEach {
      $0.textColor = ColorZip.purple
      $0.font = .systemFont(ofSize: 22, weight: .regular)
    }
    
    leftStackView.alignment = .leading
    rightStackView.alignment = .trailing
    
    [leftStackView, rightStackView].forEach {
      $0.axis = .vertical
      $0.distribution = .fill
      $0.spacing = 8
    }
    
    setConstraint()
  }
  
  // MARK: -setupConstraint
  
  private func setConstraint() {
    
    shadowView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(10)
    }
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(CGFloat.dynamicXMargin(margin: 28))
      $0.top.equalToSuperview().offset(CGFloat.dynamicYMargin(margin: 14))
    }
    lineView.snp.makeConstraints {
      $0.width.equalToSuperview().multipliedBy(0.9)
      $0.height.equalTo(0.8)
      $0.top.equalTo(titleLabel.snp.bottom).offset(6)
      $0.centerX.equalToSuperview()
    }
    
    leftStackView.snp.makeConstraints {
      $0.top.equalTo(lineView).inset(CGFloat.dynamicYMargin(margin: 10))
      $0.trailing.equalTo(shadowView.snp.centerX)
      $0.leading.equalToSuperview().inset(CGFloat.dynamicXMargin(margin: 28))
      $0.bottom.equalToSuperview().offset(CGFloat.dynamicYMargin(margin: -14))
    }
    
    rightStackView.snp.makeConstraints {
      $0.top.equalTo(lineView).inset(CGFloat.dynamicYMargin(margin: 10))
      $0.leading.equalTo(shadowView.snp.centerX)
      $0.trailing.equalToSuperview().inset(CGFloat.dynamicXMargin(margin: 38))
    }
    
    totalCalory.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(CGFloat.dynamicXMargin(margin: -38))
      $0.top.equalTo(titleLabel.snp.top)
    }
  }
}


