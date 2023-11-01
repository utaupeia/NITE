//
//  TimeSinceFormatter.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import Foundation
import SwiftUI

struct TimeSinceFormatter {
    
    static func timeSince(from date: Date) -> String {
        let now = Date()
        let components = Calendar.current.dateComponents([.minute, .hour, .day, .weekOfYear], from: date, to: now)
        
        if let week = components.weekOfYear, week > 0 {
            return week == 1 ? "1 wk" : "\(week) wks"
        } else if let day = components.day, day > 0 {
            return day == 1 ? "1 day" : "\(day) days"
        } else if let hour = components.hour, hour > 0 {
            return hour == 1 ? "1 hr" : "\(hour) hrs"
        } else if let minute = components.minute, minute > 0 {
            return minute == 1 ? "1 min" : "\(minute) mins"
        } else {
            return "Just now"
        }
    }
}


struct monthYearFormatter {
    static func format(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yy"  // e.g., "Feb 23"
        return formatter.string(from: date)
    }

}
