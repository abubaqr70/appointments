// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

public protocol FilterActionProvider {
    func filterAction(for navigationController: UINavigationController) -> UIBarButtonItem
    func isFiltersApplied() -> Bool
    func memberIDsForSelectedFilters() -> [Int]
}
