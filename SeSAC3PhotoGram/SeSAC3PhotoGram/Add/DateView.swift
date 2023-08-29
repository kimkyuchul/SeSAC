//
//  DateView.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/29.
//

import UIKit

final class DateView: BaseView {
    
    private let datepicker = {
        let v = UIDatePicker()
        v.datePickerMode = .date
        v.preferredDatePickerStyle = .wheels
        return v
    }()
    
    
    override func configureView() {
        [datepicker].forEach { view in
            addSubview(view)
        }
    }
    
    override func setConstraints() {
        datepicker.snp.makeConstraints { make in
            make.topMargin.leadingMargin.trailingMargin.equalTo(self).inset(10)
            make.height.equalTo(self).multipliedBy(0.3)
        }
    }
}

extension DateView {
    func getDate() -> Date {
        return datepicker.date
    }
}
