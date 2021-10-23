// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

extension Date {
    
    static func startOfMonth(date: Date) -> Date {
        let startMonthComponent = Calendar.current.dateComponents([.year,.month], from: date)
        return Calendar.current.date(from: startMonthComponent)!
    }
    
    static func endOfMonth(date: Date) -> Date {
        var endMonthComponents = DateComponents()
        endMonthComponents.month = 1
        endMonthComponents.second = -1
        return Calendar.current.date(byAdding: endMonthComponents, to: Date.startOfMonth(date: date)) ?? Date()
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

