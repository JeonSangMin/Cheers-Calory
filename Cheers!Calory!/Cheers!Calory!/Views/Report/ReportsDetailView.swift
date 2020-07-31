//
//  ReportsDetailView.swift
//  Cheers!Calory!
//
//  Created by 은영김 on 2020/07/06.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class ReportsDetailView: UIView {
  
  // MARK: -Property
  private let shadowView = UIView()
  private let titleLabel = UILabel()
  private let lineView = UIView()
  private let totalCalory = UILabel()
  
  var food: [Food]?
  
  // MARK: -init
  init(food: [Food]?) {
    self.food = food
    super.init(frame: .zero)
    
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
  
  // MARK: -setupUI
  
  private func setUI() {
    self.addSubviews([
      shadowView,
    ])
    
    shadowView.addSubviews([
      titleLabel,
      lineView,
      totalCalory
    ])
    
    //    shadowView.layer.masksToBounds = false
    shadowView.layer.shadowColor = UIColor.black.cgColor
    //    shadowView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
    shadowView.layer.shadowOffset = .zero
    shadowView.layer.shadowOpacity = 0.2
    shadowView.layer.shadowRadius = 4.0
    shadowView.backgroundColor = ColorZip.lightGray3
    lineView.backgroundColor = ColorZip.purple
    
    [titleLabel, totalCalory].forEach {
      $0.textColor = ColorZip.purple
      $0.font = .systemFont(ofSize: 22, weight: .regular)
    }
    setConstraint()
  }
  
  // MARK: -setupConstraint
  
  private func setConstraint() {
    
    shadowView.snp.makeConstraints {
      //      $0.leading.trailing.top.bottom.equalToSuperview().offset(8)
//      $0.height.equalTo(120)
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
    totalCalory.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(CGFloat.dynamicXMargin(margin: -38))
      $0.top.equalTo(titleLabel.snp.top)
    }
    
    
//    for (index, view) in previewSubviews.enumerated() {
//        playerScrollView.addSubview(view)
//        let leading = index == 0 ? playerScrollView.snp.leading : previewSubviews[index - 1].snp.trailing
//        view.snp.makeConstraints {
//            $0.leading.equalTo(leading)
//            $0.top.bottom.width.height.equalTo(playerScrollView)
//        }
//
//        if index == previewSubviews.count - 1 {
//            view.snp.makeConstraints {
//                $0.trailing.equalTo(playerScrollView.snp.trailing)
//            }
//        }
//
//    }
  }
  
  
  
}
