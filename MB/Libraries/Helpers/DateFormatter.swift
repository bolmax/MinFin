//
//  DateFormatter.swift
//  MB
//
//  Created by Max Bolotov on 06.08.2020.
//  Copyright © 2020 Max Bolotov. All rights reserved.
//

import Foundation

public struct DateFormatterConstants {
    static let timeFormat = "HH:mm"
    static let fullDateFormat = "yyyy-MM-dd HH:mm:ss"
    static let courseFormatter = "yyyy-MM-dd HH:mm"
}

extension DateFormatter {
    
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatterConstants.timeFormat
        return formatter
    }()
    
    static let fullFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatterConstants.fullDateFormat
        formatter.locale = Locale(identifier: "en_US")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    static let courseFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatterConstants.courseFormatter
        formatter.locale = Locale(identifier: "en_US")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}
