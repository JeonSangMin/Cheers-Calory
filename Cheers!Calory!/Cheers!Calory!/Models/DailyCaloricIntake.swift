//
//  DailyCaloricIntake.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/11.
//  Copyright © 2020 sandMan. All rights reserved.
//

import Foundation

struct DailyCaloricIntake: Codable {
    var today = Date.dateFormatting(yyyyMMDD: Keys.date.rawValue)
    
    var breakfast = [Food]()
    var lunch = [Food]()
    var dinner = [Food]()
    var snack = [Food]()
    
    var breakfastTotalCalory: Int {
        breakfast.reduce(0, { $0 + (Int($1.calory.trimmingCharacters(in: [" "])) ?? 0)})
    }
    
    var lunchTotalCalory: Int {
        lunch.reduce(0, { $0 + (Int($1.calory.trimmingCharacters(in: [" "])) ?? 0)})
    }
    
    var dinnerTotalCalory: Int {
        dinner.reduce(0, { $0 + (Int($1.calory.trimmingCharacters(in: [" "])) ?? 0)})
    }
    
    var snackTotalCalory: Int {
        snack.reduce(0, { $0 + (Int($1.calory.trimmingCharacters(in: [" "])) ?? 0)})
    }
    
    var totalCalory: Int {
        [breakfast, lunch, dinner, snack]
            .flatMap({ $0 })
            .reduce(0, { $0 + (Int($1.calory.trimmingCharacters(in: [" "])) ?? 0)})
    }
    
}
