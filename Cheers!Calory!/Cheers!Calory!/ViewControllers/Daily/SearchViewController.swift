//
//  SearchViewController.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit
import Firebase

protocol BarcodeDataDelegate {
    func sendBarcodeData(barcode: String)
}

class SearchViewController: UIViewController {
    var section = 0
    private let dao = DAO()
    private var ref: DatabaseReference!
    
    private var delegate: BarcodeDataDelegate?
    
    private let label = UILabel()
    private let searchController = UISearchController(searchResultsController: nil)
    let tableView = UITableView()
    
    //    private var dailyCaloric = DailyCaloricIntake()
    private var data = [Food]()
    private var filteredDatas = [Food]()
    
    private var isSearchBarEmpty: Bool {
        searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setConstraints()
        
        self.ref = Database.database().reference()
        view.backgroundColor = .white
        
        dao.search()
        setFoodDatas()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "음식을 검색하세요"
        
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setConstraints() {
        view.addSubview(tableView)
        let guide = view.safeAreaLayoutGuide
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(guide)
        }
    }
    
    private func setNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Search"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goBack(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "barcode"), style: .plain, target: self, action: #selector(tapBarcodeBtn(_:)))
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.searchController = searchController
    }
    
    private func setFoodDatas() {
        if let savedFoodDatas = UserDefaults.standard.object(forKey: "foodDatas") as? Data {
            let decoder = JSONDecoder()
            if let loadedFoods = try? decoder.decode([Food].self, from: savedFoodDatas) {
                self.data = loadedFoods
            }
        }
    }
    
    @objc private func goBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc private func tapBarcodeBtn(_ sender: UIBarButtonItem) {
        let camVC = CameraViewController()
        camVC.delegate = self
        present(camVC, animated: true)
    }
}

extension SearchViewController {
    
    
    private func filterContentForSearchText(searchText: String) {
        filteredDatas = data.filter { (food: Food) -> Bool in
            return food.foodName.contains(searchText)
        }
        tableView.reloadData()
    }
    
    private func barcodeSearching(barcode: String) {
        guard let tabbar = self.presentingViewController as? UITabBarController else { return print("탭바 없음")}
        guard let navi = tabbar.viewControllers?[1] as? UINavigationController else { return print("네비게이션 없음")}
        guard let dailyVC = navi.viewControllers.first as? DailyViewController else { return print("데일리 없음")}
        
        ref.child("product").child(barcode).observeSingleEvent(of: .value, with: { (DataSnapshot) in
            
            if let value = DataSnapshot.value as? NSDictionary {
                let food = Food(foodName: value["제품명"] as! String,
                                servingSize: value["상품분류"] as! String,
                                calory: value["원산지"] as! String,
                                carbohydrate: "0", fat: "0", protein: "0")
                
                switch self.section {
                case 0: DailyIntakeDB.shared.todayIntake.breakfast.append(food)
                case 1: DailyIntakeDB.shared.todayIntake.lunch.append(food)
                case 2: DailyIntakeDB.shared.todayIntake.dinner.append(food)
                case 3: DailyIntakeDB.shared.todayIntake.snack.append(food)
                default: print("안됨")
                
                dailyVC.tableView.reloadData()
                }
            } else {
                let alert = UIAlertController(title: "정보 없음", message: "해당 음식에 대한 정보가 없습니다", preferredStyle: .alert)
                let check = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(check)
                dailyVC.present(alert, animated: true, completion: nil)
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}

extension SearchViewController: BarcodeDataDelegate {
    func sendBarcodeData(barcode: String) {
        barcodeSearching(barcode: barcode)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredDatas.count
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let food: Food
        
        if isFiltering {
            food = filteredDatas[indexPath.row]
        } else {
            food = data[indexPath.row]
        }
        cell.textLabel?.text = food.foodName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tabbar = self.presentingViewController as? UITabBarController else { return print("탭바 없음")}
        guard let navi = tabbar.viewControllers?[1] as? UINavigationController else { return print("네비게이션 없음")}
        guard let dailyVC = navi.viewControllers.first as? DailyViewController else { return print("데일리 없음")}
        
        let food: Food
        
        if isFiltering {
            food = filteredDatas[indexPath.row]
        } else {
            food = data[indexPath.row]
        }
        
        switch self.section {
        case 0: DailyIntakeDB.shared.todayIntake.breakfast.append(food)
        case 1: DailyIntakeDB.shared.todayIntake.lunch.append(food)
        case 2: DailyIntakeDB.shared.todayIntake.dinner.append(food)
        case 3: DailyIntakeDB.shared.todayIntake.snack.append(food)
        default: break
        }
        
        if isFiltering {
            self.presentingViewController?.dismiss(animated: true)
        } else {
            self.dismiss(animated: true)
        }
        
        dailyVC.totalCalory =  DailyIntakeDB.shared.todayIntake.totalCalory
        dailyVC.tableView.reloadData()
        
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchText: searchBar.text!)
    }
}
