
//
//  DailyViewController.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class DailyViewController: UIViewController {
    
    let headerView = DailyHeaderView() 
    var totalCalory: Int = 0 {
        didSet {
            headerView.label.text = String(totalCalory) + " kcal"
        }
    }
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.identifier)
        return tableView
    }()
    
    //    private var today = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = CGFloat.dynamicYMargin(margin: 60)
        
        setNavigationBar()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.reloadData()
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = CGFloat.dynamicYMargin(margin: 60)
    }
    
    private func setNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Daily"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .plain, target: self, action: #selector(didTapWritButton(_:)))
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    
    
    private func setUI() {
        view.backgroundColor = .white
        [headerView, tableView].forEach {
            view.addSubview($0)
        }
        setConstraints()
    }
    
    private func setConstraints() {
        let guide = view.safeAreaLayoutGuide
        
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(guide)
            $0.height.equalTo(CGFloat.dynamicYMargin(margin: 120))
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 15))
            $0.leading.trailing.bottom.equalTo(guide)
        }
    }
    
    @objc private func didTapWritButton(_ sender: UIButton) {
        let writeVC = WriteViewController()
        
        let navi = UINavigationController(rootViewController: writeVC)
        present(navi, animated: true, completion: nil)
    }
}

extension DailyViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return DailyIntakeDB.shared.todayIntake.breakfast.count
        case 1:
            return DailyIntakeDB.shared.todayIntake.lunch.count
        case 2:
            return DailyIntakeDB.shared.todayIntake.dinner.count
        case 3:
            return DailyIntakeDB.shared.todayIntake.snack.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as! DailyTableViewCell
        
        var name = ""
        var base = ""
        var calory = ""
        
        switch indexPath.section {
        case 0:
            name = DailyIntakeDB.shared.todayIntake.breakfast[indexPath.row].foodName
            base = DailyIntakeDB.shared.todayIntake.breakfast[indexPath.row].servingSize
            calory = DailyIntakeDB.shared.todayIntake.breakfast[indexPath.row].calory
            
        case 1:
            name = DailyIntakeDB.shared.todayIntake.lunch[indexPath.row].foodName
            base = DailyIntakeDB.shared.todayIntake.lunch[indexPath.row].servingSize
            calory = DailyIntakeDB.shared.todayIntake.lunch[indexPath.row].calory
        case 2:
            name = DailyIntakeDB.shared.todayIntake.dinner[indexPath.row].foodName
            base = DailyIntakeDB.shared.todayIntake.dinner[indexPath.row].servingSize
            calory = DailyIntakeDB.shared.todayIntake.dinner[indexPath.row].calory
        case 3:
            name = DailyIntakeDB.shared.todayIntake.snack[indexPath.row].foodName
            base = DailyIntakeDB.shared.todayIntake.snack[indexPath.row].servingSize
            calory = DailyIntakeDB.shared.todayIntake.snack[indexPath.row].calory
        default:
            break
        }
        
        cell.foodName.text = name
        cell.foodBase.text = "\(base)(g)"
        
        if base.contains("가공") {
            cell.foodKcal.text = "\(calory)"
        } else {
            cell.foodKcal.text = "\(calory) kcal"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = DailySectionHeaderView()
        view.section = section
        view.backgroundColor = ColorZip.purple
        view.delegate = self
        
        switch section {
        case 0:
            view.foodLabel.text = "아침"
        case 1:
            view.foodLabel.text = "점심"
        case 2:
            view.foodLabel.text = "저녁"
        case 3:
            view.foodLabel.text = "간식"
        default:
            break
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch indexPath.section {
            case 0:
                DailyIntakeDB.shared.todayIntake.breakfast.remove(at: indexPath.row)
            case 1:
                DailyIntakeDB.shared.todayIntake.lunch.remove(at: indexPath.row)
            case 2:
                DailyIntakeDB.shared.todayIntake.dinner.remove(at: indexPath.row)
            case 3:
                DailyIntakeDB.shared.todayIntake.snack.remove(at: indexPath.row)
            default:
                break
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        self.totalCalory =  DailyIntakeDB.shared.todayIntake.totalCalory
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var detail: Food?
        
        switch indexPath.section {
        case 0:
            detail = DailyIntakeDB.shared.todayIntake.breakfast[indexPath.row]
        case 1:
            detail = DailyIntakeDB.shared.todayIntake.lunch[indexPath.row]
        case 2:
            detail = DailyIntakeDB.shared.todayIntake.dinner[indexPath.row]
        case 3:
            detail = DailyIntakeDB.shared.todayIntake.snack[indexPath.row]
        default:
            break
        }
        
        if (detail?.servingSize.contains("가공"))! {
            let productDetailVC = ProductDetailViewController(detail: detail!)
            productDetailVC.modalTransitionStyle = .crossDissolve
            
            self.present(productDetailVC, animated: true, completion: {
                productDetailVC.presentationController?.presentedView?.gestureRecognizers?[0].isEnabled = false
            })
        } else {
            let foodDetailVC = FoodDetailViewController(detail: detail!)
            foodDetailVC.modalTransitionStyle = .crossDissolve
            
            self.present(foodDetailVC, animated: true, completion: {
                // 모달형식의 ViewController 내려서 끌 수 없도록 막음
                foodDetailVC.presentationController?.presentedView?.gestureRecognizers?[0].isEnabled = false
            })
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat.dynamicYMargin(margin: 50)
    }
    
    // 이건 어디에 쓰는 거지
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let indexPathValue = indexPath
        return indexPathValue
    }
    
    
}

extension DailyViewController: DailySectionHeaderViewDelegate {
    func didTapPlusButton(section: Int) {
        let searchVC = SearchViewController()
        searchVC.section = section
        
        let navi = UINavigationController(rootViewController: searchVC)
        present(navi, animated: true, completion: nil)
    }
    
    
    
}
