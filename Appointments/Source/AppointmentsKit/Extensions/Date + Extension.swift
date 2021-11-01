// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

extension Date {
    
    static func startOfMonth(date: Date) -> Date {
        var comp = Calendar.current.dateComponents(
            [.era, .year, .month, .day],
            from: date)
        
        comp.day = 1
        return Calendar.current.date(from: comp) ?? Date()
    }
    
    static func numberOfDaysInMonthCount(date: Date) -> Int {
        let dayRange =  Calendar.current.range(of: .day, in: .month, for: date)
        return dayRange?.count ?? 0
    }
    
    static func endOfMonth(date: Date) -> Date {
        let dayCount : Int = Date.numberOfDaysInMonthCount(date: date)
        
        var comp = Calendar.current.dateComponents(
            [.era, .year, .month, .day],
            from: date)
        
        comp.day = dayCount
        comp.hour = 23
        comp.minute = 59
        comp.second = 0
        return Calendar.current.date(from: comp) ?? Date()
    }
    
    static func startOfDay(date: Date) -> Date {
        return Calendar.current.startOfDay(for: date)
    }
    
    static func endOfDay(date: Date) -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: Date.startOfDay(date: date)) ?? Date ()
    }
    
    static func getSuffixDate(date: Date) -> String{
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        
        switch day {
        case 11...13: return "th"
        default:
            switch day % 10 {
            case 1: return "st"
            case 2: return "nd"
            case 3: return "rd"
            default: return "th"
            }
        }
    }
    
}

