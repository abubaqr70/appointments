// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

public protocol UserDataStore {
    var currentUser: [String: Any]? { get }
}
