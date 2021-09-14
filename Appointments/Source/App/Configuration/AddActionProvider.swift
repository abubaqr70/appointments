// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

public protocol AddActionProvider {
    func addAction(for navigationController: UINavigationController) -> UIBarButtonItem
}
