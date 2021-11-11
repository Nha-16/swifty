//
//  Date+Extension.swift
//  swifty-demo
//
//  Created by Mavin on 10/11/21.
//

import Foundation

extension Date {
    func getStringFromDateFormat(format: String)->String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
}
