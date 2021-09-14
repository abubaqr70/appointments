// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

public protocol FacilityDataStore {
    var currentFacility: [String: Any]? { get }
}
