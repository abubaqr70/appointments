// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxSwift

class RxUITableViewCell: UITableViewCell, DequeueInitializable {
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
        super.prepareForReuse()
    }
}
