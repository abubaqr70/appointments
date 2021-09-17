// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

extension Bundle {
    static var module: Bundle {
        return Bundle(for: Self.self)
    }
}
