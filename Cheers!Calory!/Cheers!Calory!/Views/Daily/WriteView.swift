//
//  WriteView.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/07/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class WriteView: UIView {
    
    let setTimeSegment = UISegmentedControl(items: ["아침", "점심", "저녁", "간식"])
    let foodNameTextField = UITextField()
    let portionSizeTextField = UITextField()
    let caloryTextField = UITextField()
    let proteinTextField = UITextField()
    let fatTextField = UITextField()
    let carbohydrateTextField = UITextField()
    
    // MARK: -init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
//        addDoneButtonOnKeyboard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .white
        self.addSubview(setTimeSegment)
        setTimeSegment.selectedSegmentIndex = 0
        setTimeSegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .ultraLight)], for: .normal)
        setTimeSegment.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .light),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ], for: .selected)
        setTimeSegment.layer.borderWidth = 1
        setTimeSegment.layer.borderColor = ColorZip.lightGray.cgColor
        setTimeSegment.selectedSegmentTintColor =  #colorLiteral(red: 0.4941176471, green: 0.2235294118, blue: 0.9843137255, alpha: 1) // 126, 57, 251
        
        self.addSubview(foodNameTextField)
        foodNameTextField.delegate = self
        foodNameTextField.font = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
        foodNameTextField.textAlignment = .center
        foodNameTextField.layer.borderWidth = 1
        foodNameTextField.layer.cornerRadius = 8
        foodNameTextField.layer.borderColor = ColorZip.lightGray.cgColor
        
        portionSizeTextField.placeholder = "섭취량(g)"
        caloryTextField.placeholder = "칼로리(kcal)"
        proteinTextField.placeholder = "단백질(g)"
        fatTextField.placeholder = "지방(g)"
        carbohydrateTextField.placeholder = "탄수화물(g)"
        
        [portionSizeTextField, caloryTextField, proteinTextField, fatTextField, carbohydrateTextField].forEach {
            self.addSubview($0)
            $0.delegate = self
            $0.keyboardType = .numberPad
            $0.font = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
            $0.textAlignment = .center
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 8
            $0.layer.borderColor = ColorZip.lightGray.cgColor
            
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.width.equalTo(self.snp.width).multipliedBy(0.6)
                $0.height.equalTo(CGFloat.dynamicYMargin(margin: 50))
            }
            
            $0.inputAccessoryView = createToolBars(text: $0.placeholder!)
        }
        
        
        
        
        if let vc = self.getOwningViewController() {
            vc.navigationController?.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        setConstraints()
    }
    
    private func setConstraints() {
        // 높이 : 50, 넓이 0.8배
        let ySpace = CGFloat.dynamicYMargin(margin: 25)
        setTimeSegment.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.snp.top).offset(CGFloat.dynamicYMargin(margin: 30))
            $0.width.equalTo(self.snp.width).multipliedBy(0.8)
            $0.height.equalTo(CGFloat.dynamicYMargin(margin: 50))
        }
        
        
        foodNameTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(setTimeSegment.snp.bottom).offset(ySpace)
            $0.width.equalTo(self.snp.width).multipliedBy(0.6)
            $0.height.equalTo(CGFloat.dynamicYMargin(margin: 50))
        }
        
        portionSizeTextField.snp.makeConstraints {
            $0.top.equalTo(foodNameTextField.snp.bottom).offset(ySpace)
        }
        
        caloryTextField.snp.makeConstraints {
            $0.top.equalTo(portionSizeTextField.snp.bottom).offset(ySpace)
        }
        
        proteinTextField.snp.makeConstraints {
            $0.top.equalTo(caloryTextField.snp.bottom).offset(ySpace)
        }
        
        fatTextField.snp.makeConstraints {
            $0.top.equalTo(proteinTextField.snp.bottom).offset(ySpace)
        }
        
        carbohydrateTextField.snp.makeConstraints {
            $0.top.equalTo(fatTextField.snp.bottom).offset(ySpace)
        }
    }
    
    // MARK: 숫자키보드에 done버튼 추가
    private func createToolBars(text: String) -> UIToolbar {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.barStyle = .default
        
        let label = UILabel()
        label.text = text
        let labelItem = UIBarButtonItem(customView: label)
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction(_:)))
        
        let items = [labelItem, flexSpace, done]
        toolbar.items = items
        toolbar.sizeToFit()
        
        return toolbar
    }
    
    
    @objc private func doneButtonAction(_ sender: UITextField){
        
//        switch sender {
//        case portionSizeTextField.inputAccessoryView.butto:
//            caloryTextField.becomeFirstResponder()
//        case caloryTextField:
//            proteinTextField.becomeFirstResponder()
//        case proteinTextField:
//            fatTextField.becomeFirstResponder()
//        case fatTextField:
//            carbohydrateTextField.becomeFirstResponder()
//        default:
//            break
//        }
        portionSizeTextField.resignFirstResponder()
        caloryTextField.resignFirstResponder()
        proteinTextField.resignFirstResponder()
        fatTextField.resignFirstResponder()
        carbohydrateTextField.resignFirstResponder()
    }
    
    @objc private func didTapCompleteButton(_ sender: UIButton) {
        guard let foodText = foodNameTextField.text, let portionSizeText = portionSizeTextField.text, let caloryText = caloryTextField.text, let proteinText = proteinTextField.text, let fatText = fatTextField.text, let carbohydrateText = carbohydrateTextField.text else { return }
        let food = Food(foodName: foodText, servingSize: portionSizeText, calory: caloryText, carbohydrate: carbohydrateText, fat: fatText, protein: proteinText)
        
        switch setTimeSegment.selectedSegmentIndex {
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
    }
}

extension WriteView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == foodNameTextField {
            portionSizeTextField.becomeFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let foodText = foodNameTextField.text, let portionSizeText = portionSizeTextField.text, let caloryText = caloryTextField.text, let proteinText = proteinTextField.text, let fatText = fatTextField.text, let carbohydrateText = carbohydrateTextField.text else { return }
        
        guard let vc = self.getOwningViewController() else { return }
        
        if !foodText.isEmpty && !portionSizeText.isEmpty && !caloryText.isEmpty && !proteinText.isEmpty && !fatText.isEmpty && !carbohydrateText.isEmpty {
            vc.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            vc.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == foodNameTextField {
            return true
        } else {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 4
        }
    }
}
