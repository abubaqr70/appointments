//
//  UIFont+Extension.swift
//  Appointments
//
//  Created by Hussaan S on 06/09/2021.
//

import Foundation

enum AppFontStyle {
    case f100
    case f100Italic
    case f300
    case f300Italic
    case f500
    case f500Italic
    case f700
    case f700Italic
    case f1000
    case f1000Italic
}

extension AppFontStyle {
    var name: String {
        switch self {
        case .f100:
            return "MuseoSansRounded-100"
        case .f100Italic:
            return "MuseoSansRounded-100Italic"
        case .f300:
            return "MuseoSansRounded-300"
        case .f300Italic:
            return "MuseoSansRounded-300Italic"
        case .f500:
            return "MuseoSansRounded-500"
        case .f500Italic:
            return "MuseoSansRounded-500Italic"
        case .f700:
            return "MuseoSansRounded-700"
        case .f700Italic:
            return "MuseoSansRounded-700Italic"
        case .f1000:
            return "MuseoSansRounded-1000"
        case .f1000Italic:
            return "MuseoSansRounded-1000Italic"
        }
    }
}

extension UIFont {
    static func appFont(withStyle style: AppFontStyle, size: CGFloat) -> UIFont {
        return UIFont(name: style.name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
