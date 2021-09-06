//  Created by Hussaan Saeed on 22/10/2019.

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
