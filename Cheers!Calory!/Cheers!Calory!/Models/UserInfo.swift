//
//  UserInfo.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import Foundation

struct UserInfo: Codable {
    static let shared = UserInfo()
    private init(){}
    
    var selectedItem: Int = 0
    var nickName: String = ""
    var gender: String = ""
    var age: Int = 0
    var height: Double = 0
    var weight: Double = 0
    var today: String = ""
//    var bmi: Double {
//        return weight / (0.01 * height) / (0.01 * height)
//    }
//    var averageWeight: Double {
//        return (0.01 * height) * (0.01 * height) * bmi
//    }
    var healthyWeight: Double {
        return (height - 100) * 0.9
    }
}
