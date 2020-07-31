//
//  RecommendedCaloriesViewController.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class RecommendedCaloriesViewController: UIViewController {
  
  // MARK: -Property
  private let mainView = RecommendedMainView()
  private let bodyView = RecommendedBodyView()
  private let bottomView = RecommendedBottomView()
  private var userInfo = UserInfo.shared
//  private var userInfo = UserDefaults.standard.data(forKey: "userInfo")
  
  
//  private let caloryView1 = CaloryView()

  // MARK: -Lift cycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

//    caloryView1.configue(backColor: ColorZip.morning, title: "아침", calory: "700")
    setupUI()
    readUserDefault()
  }
  
  // MARK: -Action
  //25 30 35 40
  //평균체중 * 활동지수 = 권장칼로리
  private func readUserDefault() {
//    var 권장칼로리: Double
    guard let data = UserDefaults.standard.data(forKey: "userInfo") else { return }
    if let userInfo = try? JSONDecoder().decode(UserInfo.self, from: data) {
        self.userInfo = userInfo
    }
//    권장칼로리 = userInfo.averageWeight * Double(userInfo.selectedItem)
    mainView.configue(info: userInfo.nickName, age: String(userInfo.age), height: String(Int(userInfo.height)), weight: String(Int(userInfo.weight)))
    
    switch userInfo.selectedItem {
    case 0:
      let calories: Double = userInfo.healthyWeight * 25
      let dailyCalories: Double = calories / 10
      bodyView.configue(weight: String(Int(userInfo.healthyWeight)), calories: String(Int(calories)))
      bottomView.configue(morning: String(Int(dailyCalories * 3)), lunch: String(Int(dailyCalories * 4)), evening: String(Int(dailyCalories * 2)), snack: String(Int(dailyCalories * 1)))
    case 1:
      let calories: Double = userInfo.healthyWeight * 30
      let dailyCalories: Double = calories / 10
      bodyView.configue(weight: String(Int(userInfo.healthyWeight)), calories: String(Int(calories)))
      bottomView.configue(morning: String(Int(dailyCalories * 3)), lunch: String(Int(dailyCalories * 4)), evening: String(Int(dailyCalories * 2)), snack: String(Int(dailyCalories * 1)))
    case 2:
      let calories: Double = userInfo.healthyWeight * 35
      let dailyCalories: Double = calories / 10
      bodyView.configue(weight: String(Int(userInfo.healthyWeight)), calories: String(Int(calories)))
      bottomView.configue(morning: String(Int(dailyCalories * 3)), lunch: String(Int(dailyCalories * 4)), evening: String(Int(dailyCalories * 2)), snack: String(Int(dailyCalories * 1)))
    case 3:
      let calories: Double = userInfo.healthyWeight * 40
      let dailyCalories: Double = calories / 10
      bodyView.configue(weight: String(Int(userInfo.healthyWeight)), calories: String(Int(calories)))
      bottomView.configue(morning: String(Int(dailyCalories * 3)), lunch: String(Int(dailyCalories * 4)), evening: String(Int(dailyCalories * 2)), snack: String(Int(dailyCalories * 1)))
    default:
      break
    }
  }
  
  // MARK: -setupUI
  private func setupUI() {
    view.addSubviews([mainView, bodyView, bottomView])
//    mainView.configue(info: UserInfo.shared.nickName, age: String(UserInfo.shared.age), height: String(UserInfo.shared.height), weight: String(UserInfo.shared.weight))
//    bodyView.configue(nickname: UserInfo.shared.nickName, weight: String(UserInfo.shared.averageWeight), calories: "700")
//    mainView.configue(info: userInfo.nickName, age: String(userInfo.age), height: String(userInfo.height), weight: String(userInfo.weight))
    setupConstraint()
  }
  
  // MARK: -setupConstraint
  
  private func setupConstraint() {
    mainView.snp.makeConstraints {
      $0.top.trailing.leading.equalToSuperview()
      $0.height.equalTo(CGFloat.dynamicYMargin(margin: 230))
    }
    bodyView.snp.makeConstraints {
      $0.top.equalTo(mainView.snp.bottom)
      $0.trailing.leading.equalToSuperview()
      $0.height.equalTo(CGFloat.dynamicYMargin(margin: 190))
    }
    bottomView.snp.makeConstraints {
      $0.top.equalTo(bodyView.snp.bottom)
      $0.trailing.leading.bottom.equalToSuperview()
    }
//    caloryView1.snp.makeConstraints {
//      $0.top.equalTo(bodyView.snp.bottom).offset(20)
//      $0.leading.equalToSuperview().offset(20)
//    }
  }
  
}
