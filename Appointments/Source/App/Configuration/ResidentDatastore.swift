// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

public protocol ResidentDataStore {
    var currentResident: [String: Any]? { get }
}
