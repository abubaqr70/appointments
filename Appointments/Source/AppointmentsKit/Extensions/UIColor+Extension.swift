// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

enum AppColorName {
    case appSkyBlue
    case appGrayLight
    case appGrayDark
    case appGreen
}

extension UIColor {
    static func appColor(ofName name: AppColorName) -> UIColor {
        switch name {
        case .appSkyBlue: return UIColor(named: "color_app_blue", in: Bundle.resource, compatibleWith: nil) ?? .blue
        case .appGrayLight: return UIColor(named: "color_app_light_gray", in: Bundle.resource, compatibleWith: nil) ?? .lightGray
        case .appGrayDark: return UIColor(named: "color_app_dark_gray", in: Bundle.resource, compatibleWith: nil) ?? .darkGray
        case .appGreen: return UIColor(named: "color_app_green", in: Bundle.resource, compatibleWith: nil) ?? .green
        }
    }
}

extension UIColor {
    
    static var appSkyBlue: UIColor {
        return .appColor(ofName: .appSkyBlue)
    }
    
    static var appGrayLight: UIColor {
        return .appColor(ofName: .appGrayLight)
    }
    
    static var appGrayDark: UIColor {
        return .appColor(ofName: .appGrayDark)
    }
    
    static var appGreen: UIColor {
        return .appColor(ofName: .appGreen)
    }
}
