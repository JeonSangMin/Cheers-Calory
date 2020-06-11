//
//  DailyIntakeDB.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/11.
//  Copyright © 2020 sandMan. All rights reserved.
//

import Foundation

struct DailyIntakeDB: Encodable {
    static var shared = DailyIntakeDB()
    private init(){}
    
    var todayIntake: DailyCaloricIntake? = nil
    var dailyCaloricIntakeArray = [DailyCaloricIntake]()
}
