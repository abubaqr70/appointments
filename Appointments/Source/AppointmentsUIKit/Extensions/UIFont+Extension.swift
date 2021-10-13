// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

enum AppFontStyle {
    
    case largeTitle
    case title1
    case title2
    case title3
    case headline
    case body
    case callout
    case subhead
    case footnote
    case caption1
    case caption2
    
}

extension AppFontStyle {
    var name: String {
        switch self {
        case .headline:
            return "MuseoSansRounded-100"
        case .footnote:
            return "MuseoSansRounded-100Italic"
        case .title1,.title2:
            return "MuseoSansRounded-300"
//        case .title2:
//            return "MuseoSansRounded-300Italic"
        case .body,.callout,.title3:
            return "MuseoSansRounded-500"
//        case .title3:
//            return "MuseoSansRounded-500Italic"
        case .subhead:
            return "MuseoSansRounded-700"
        case .caption1:
            return "MuseoSansRounded-700Italic"
        case .largeTitle:
            return "MuseoSansRounded-1000"
        case .caption2:
            return "MuseoSansRounded-1000Italic"
        }
    }
}

extension UIFont {
    static func appFont(withStyle style: AppFontStyle, size: CGFloat) -> UIFont {
        return UIFont(name: style.name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
