//
//  ProductDetailViewController.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/07/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    var dailyIntakeDetail: Food?
    
    init(detail: Food) {
        self.dailyIntakeDetail = detail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let foodTitle = UILabel()
    
    private let kindOfProductImage = UIImageView()
    private let nameOfManufacturerImage = UIImageView()
    
    private let kindOfProduct = UILabel()
    private let nameOfManufacturer = UILabel()
    
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
            $0.height.equalToSuperview().multipliedBy(0.25)
        }
        
        checkButton.layer.addBorder([.top], color: ColorZip.lightGray, width: 0.5)
    }
    
    // 델리게이트 패턴으로 레이블 타이틀 전달해줄것
    private func setUI() {
        view.backgroundColor = ColorZip.alert
        setLabelText()
        setConstraints()
    }
    
    private func setLabelText() {
        [foodTitle, checkButton].forEach {
            view.addSubview($0)
        }
        
        [kindOfProductImage, nameOfManufacturerImage].forEach {
            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalTo(view.snp.leading).offset(CGFloat.dynamicXMargin(margin: 10))
                $0.width.equalTo(CGFloat.dynamicXMargin(margin: 20))
                $0.height.equalTo(CGFloat.dynamicYMargin(margin: 30))
            }
        }
        
        [kindOfProduct, nameOfManufacturer].forEach {
            view.addSubview($0)
            $0.font = UIFont.dynamicFont(fontSize: 15, weight: .ultraLight)
        }
        
        foodTitle.font = UIFont.dynamicFont(fontSize: 18, weight: .bold)
        
        kindOfProductImage.image = UIImage(named: "classification")
        nameOfManufacturerImage.image = UIImage(named: "manufacturer")
    
        if let detail = dailyIntakeDetail {
            foodTitle.text = "\(detail.foodName)" // 제품명
            kindOfProduct.text = "\(detail.servingSize)" // 상품분류
            nameOfManufacturer.text = "\(detail.calory)" // 제조사
        }
        
        checkButton.setTitle("확인", for: .normal)
        checkButton.setTitleColor(.systemBlue, for: .normal)
        checkButton.addTarget(self, action: #selector(didTapCheckButton(_:)), for: .touchUpInside)
    }
    
    private func setConstraints() {
        let yMargin = CGFloat.dynamicYMargin(margin: 10)
        let xMargin = CGFloat.dynamicXMargin(margin: 5)
        
        foodTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(yMargin * 2)
        }
        
        kindOfProductImage.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.centerY).offset((-yMargin / 2))
        }
        
        nameOfManufacturerImage.snp.makeConstraints {
            $0.top.equalTo(view.snp.centerY).offset((yMargin / 2))
        }
                
        kindOfProduct.snp.makeConstraints {
            $0.centerY.equalTo(kindOfProductImage.snp.centerY)
            $0.leading.equalTo(kindOfProductImage.snp.trailing).offset(xMargin)
        }
        
        nameOfManufacturer.snp.makeConstraints {
            $0.centerY.equalTo(nameOfManufacturerImage.snp.centerY)
            $0.leading.equalTo(nameOfManufacturerImage.snp.trailing).offset(xMargin)
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
