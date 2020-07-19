//
//  Extensions.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    // rootView 교체 할 때 애니메이션 넣는 기능
    func switchRootViewController(_ viewController: UIViewController,  animated: Bool, duration: TimeInterval, options: UIView.AnimationOptions, completion: (() -> Void)?) {
        guard animated else {
            rootViewController = viewController
            return
        }
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }) { _ in
            completion?()
        }
    }
}

extension UITextField {
    // textfield에 키보드 대신 datePicker 넣는 기능
    func setInputViewDatePicker(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date
        
        // 나이 제한: 10세부터 100세까지
        datePicker.maximumDate = NSCalendar.current.date(byAdding: .year, value: -10, to: Date())
        datePicker.minimumDate = NSCalendar.current.date(byAdding: .year, value: -100, to: Date())
        datePicker.locale = Locale(identifier: "ko_KR")
        self.inputView = datePicker
        
        // datePicker 위에 확인 취소 버튼 만들기
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "취소", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "확인", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}

extension CALayer {
    
    // 쓰진 않았는데 유용할거 같아서 남겨둠 view Layer 그릴때 일부분만 선택해서 그릴수 있도록 하는 기능
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case .top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case .bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case .left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case .right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}

extension UIButton {
    
    // 버튼 상태별로 백그라운드 컬러 지정 할 수 있는 기능 ex) 버튼의 state가 .normal 일땐 보라색, .disabled 일 땐 회색 등
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(backgroundImage, for: state)
    }
}

extension Date {
    static func dateFormatting(yyyyMMDD: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = yyyyMMDD
        let convertedDate = dateFormatter.string(from: Date())
        return convertedDate
    }
}

extension UserDefaults {
    open func setStruct<T: Codable>(_ value: T?, forKey defaultName: String){
        let data = try? JSONEncoder().encode(value)
        set(data, forKey: defaultName)
    }
    
    open func structData<T>(_ type: T.Type, forKey defaultName: String) -> T? where T : Decodable {
        guard let encodedData = data(forKey: defaultName) else {
            return nil
        }
        
        return try! JSONDecoder().decode(type, from: encodedData)
    }
    
    open func setStructArray<T: Codable>(_ value: [T], forKey defaultName: String){
        let data = value.map { try? JSONEncoder().encode($0) }
        
        set(data, forKey: defaultName)
    }
    
    open func structArrayData<T>(_ type: T.Type, forKey defaultName: String) -> [T] where T : Decodable {
        guard let encodedData = array(forKey: defaultName) as? [Data] else {
            return []
        }
        
        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
}

func getUserInfo() -> UserInfo? {
    guard let userData = UserDefaults.standard.object(forKey: "userInfo") as? Data else { return nil }
    let user = try? JSONDecoder().decode(UserInfo.self, from: userData)
    return user
}

extension CGFloat {
    
    static func dynamicXMargin(margin: CGFloat) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let width = bounds.width
        let base: CGFloat = 375.0
        let multiflire = width / base
        let result = (margin * multiflire)
        return result.rounded()
    }
    
    static func dynamicYMargin(margin: CGFloat) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        let base: CGFloat = 812.0 // 11Pro, iphone X, XS => 5.8 inch
        let multiflire = height / base
        let result = (margin * multiflire)
        return result.rounded()
    }
    
}

//MARK: UIView Extensions
extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}

extension UIFont {
    class func dynamicFont(fontSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        let base: CGFloat = 812.0 // 11Pro, iphone X, XS => 5.8 inch
        
        let multiflire: CGFloat = height / base
        
        return systemFont(ofSize: size * multiflire, weight: weight)
    }
}

extension UIResponder {
    // MARK: view에서 view 자신이 addSubView 되어있는 viewController에 접근하고 싶을 때 사용함
    // ex) writeView는 WriteViewController가 가지고 있음, writeView에서 VC의 NavigationController에 접근해야 할 때 사용할 수 있음
    func getOwningViewController() -> UIViewController? {
        var nextResponser = self
        while let next = nextResponser.next {
            nextResponser = next
            if let viewController = nextResponser as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
