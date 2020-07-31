//
//  SetRootViewController.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//
import UIKit

// 루트 뷰 바꿔주는 기능
func setRootView(window: UIWindow) {
    window.backgroundColor = .white
    
    let tabBarVC = UITabBarController()
    let startVC = UINavigationController(rootViewController: FirstUserInfoViewController())
//    startVC.isNavigationBarHidden = true
    
    let main = UINavigationController(rootViewController: RecommendedCaloriesViewController())
    let daily = UINavigationController(rootViewController: DailyViewController())
    let record = UINavigationController(rootViewController: ReportViewController())
//    let record = UINavigationController(rootViewController: ReportDetailViewController())
    
    main.tabBarItem = UITabBarItem(title: "Info", image: UIImage(named: "InfoIcon"), tag: 0)
    daily.tabBarItem = UITabBarItem(title: "Kcal", image: UIImage(named: "Kcal"), tag: 1)
    record.tabBarItem = UITabBarItem(title: "Report", image: UIImage(named: "history"), tag: 2)
    
    UITabBar.appearance().tintColor = ColorZip.purple
    
    let tabBarList = [main, daily, record]
    tabBarVC.viewControllers = tabBarList
    
    // 유저디폴트가 있으면 탭바 컨트롤러, 없으면 startVC로
    // startVC에서 입력이 끝나면, rootViewController가 tabBarVC로 바뀜 이때 그냥 바뀌면 밋밋하니까 애니메이션 삽입
    if (UserDefaults.standard.data(forKey: "userInfo")) != nil {
        // UIWindowExtension에 정의
        window.switchRootViewController(tabBarVC, animated: true, duration: 0.5, options: .transitionCrossDissolve, completion: nil)
    } else {
        window.rootViewController = startVC
    }
    
    window.makeKeyAndVisible()
}
