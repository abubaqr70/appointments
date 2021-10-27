// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

public protocol FilterActionProvider {
    func addNavigation(for navigationController: UINavigationController)
    func isFiltersApplied() -> Bool
    func memberIDsForSelectedFilters() -> [Int]
    func filterButtonAction()
    func allSelectedGroups() -> [Int]
    func allSelectedResidents() -> [Int]
}
