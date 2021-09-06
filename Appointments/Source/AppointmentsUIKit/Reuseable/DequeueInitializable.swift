// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import UIKit

protocol DequeueInitializable {
    static var reuseIdentifier: String { get }
}

extension DequeueInitializable where Self: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension DequeueInitializable where Self: UICollectionView {
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
