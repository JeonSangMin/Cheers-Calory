//
//  DailyIntakeDB.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/11.
//  Copyright © 2020 sandMan. All rights reserved.
//

import Foundation


struct DailyIntakeDB: Codable {
    static var shared: DailyIntakeDB = DailyIntakeDB()
    private init(){
        setDailyIntakeDBObject()
    }
    
    // 투데이에 변동이 생기면 유저디폴트에 저장
    var todayIntake = DailyCaloricIntake() {
        didSet {
            let key = todayIntake.today
            print("오늘식단변동:", key)
            UserDefaults.standard.set(try? JSONEncoder().encode(todayIntake), forKey: key)
        }
    }
    
    var keyList: [String] = [] {
        didSet {
            print(self.keyList)
            UserDefaults.standard.set(self.keyList, forKey: Keys.keyList.rawValue)
        }
    }
    
    func getDailyIntake(index: Int) -> DailyCaloricIntake? {
        let key = keyList[index]
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        let dailyIntake = try? JSONDecoder().decode(DailyCaloricIntake.self, from: data)
        return dailyIntake
    }
    
    func getDailyIntake(key: String) -> DailyCaloricIntake? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        let dailyIntake = try? JSONDecoder().decode(DailyCaloricIntake.self, from: data)
        return dailyIntake
    }
    
    private mutating func setDailyIntakeDBObject() {
        
        let keyListData = UserDefaults.standard.stringArray(forKey: Keys.keyList.rawValue)
        self.keyList = keyListData ?? []
        
        let dateString = Date.dateFormatting(yyyyMMDD: Keys.date.rawValue)
        
        guard let data = UserDefaults.standard.data(forKey: dateString)
        else {
            UserDefaults.standard.set(try? JSONEncoder().encode(todayIntake), forKey: todayIntake.today)
            self.keyList.insert(dateString, at: 0)
            return
        }
        
        if let temp = try? JSONDecoder().decode(DailyCaloricIntake.self, from: data) {
            self.todayIntake = temp
        }
    }
    
}

enum Keys: String {
    case date = "yyyy년 MM월 dd일"
    case keyList
}
