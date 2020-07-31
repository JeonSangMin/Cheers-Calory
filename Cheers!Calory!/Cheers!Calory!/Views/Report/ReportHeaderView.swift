//
//  ReportHeaderView.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/26.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit
import Charts

class ReportHeaderView: UIView {
    
    let chartView = LineChartView()
    
    
    // 레이블도 해야하니깐 해당 날짜의 요일 구하는 함수 만들어서 DailyCaloricIntake에 계산프로퍼티 작성해줘서 거기에서 꺼내서 레이블에 넣어주자 => 안됨
    // 오늘 값 업데이트랑 x축 레이블 설정하는 방법 수정할 것
    
    // MARK: -init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubview(chartView)
        setConstraints()
        setChartView()
//        updateGraph()
    }
    
    private func setConstraints() {
        chartView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview().multipliedBy(0.95)
        }
    }
    
    
    private func setChartView() {
        chartView.rightAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.chartDescription?.text = "지난 일주일간 칼로리 추이"
        chartView.xAxis.granularity = 1
        
    }
    
    
    
    
}
