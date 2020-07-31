//
//  WriteViewController.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/07/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController {
    
    private let writeView = WriteView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setNavigationBar()
    }
    
    private func setUI() {
        view.addSubview(writeView)
        let guide = view.safeAreaLayoutGuide
        writeView.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(guide)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "직접 입력하기"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goBack(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(didTapCompleteButton(_:)))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc private func goBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc private func didTapCompleteButton(_ sender: UIButton) {
        guard let foodText = writeView.foodNameTextField.text, let portionSizeText = writeView.portionSizeTextField.text, let caloryText = writeView.caloryTextField.text, let proteinText = writeView.proteinTextField.text, let fatText = writeView.fatTextField.text, let carbohydrateText = writeView.carbohydrateTextField.text else { return }
        let food = Food(foodName: foodText, servingSize: portionSizeText, calory: caloryText, carbohydrate: carbohydrateText, fat: fatText, protein: proteinText)
        
        switch writeView.setTimeSegment.selectedSegmentIndex {
        case 0:
            DailyIntakeDB.shared.todayIntake.breakfast.append(food)
        case 1:
            DailyIntakeDB.shared.todayIntake.lunch.append(food)
        case 2:
            DailyIntakeDB.shared.todayIntake.dinner.append(food)
        case 3:
            DailyIntakeDB.shared.todayIntake.snack.append(food)
        default:
            break
        }
        guard let tabbar = self.presentingViewController as? UITabBarController else { return print("탭바 없음")}
        guard let navi = tabbar.viewControllers?[1] as? UINavigationController else { return print("네비게이션 없음")}
        guard let dailyVC = navi.viewControllers.first as? DailyViewController else { return print("데일리 없음")}
        
        dailyVC.tableView.reloadData()
        dailyVC.totalCalory =  DailyIntakeDB.shared.todayIntake.totalCalory
        self.dismiss(animated: true, completion: nil)
    }
    
}
