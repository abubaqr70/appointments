// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

extension Date {
    
    static func startOfMonth(with date: Date) -> Date {
        let startMonthComponent = Calendar.current.dateComponents([.year,.month], from: date)
        return Calendar.current.date(from: startMonthComponent)!
    }

    static func endOfMonth(with date: Date) -> Date {
        var endMonthComponents = DateComponents()
        endMonthComponents.month = 1
        endMonthComponents.second = -1
        return Calendar.current.date(byAdding: endMonthComponents, to: Date.startOfMonth(with: date)) ?? Date()
    }

    static func startOfDay(with date: Date) -> Date {
        return Calendar.current.startOfDay(for: date)
    }

    static func endOfDay(with date: Date) -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: Date.startOfDay(with: date)) ?? Date ()
    }

}

