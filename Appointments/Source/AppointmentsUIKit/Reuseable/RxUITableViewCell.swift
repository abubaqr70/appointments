//  Created by Hussaan Saeed on 24/10/2019.

import Foundation
import RxSwift

class RxUITableViewCell: UITableViewCell, DequeueInitializable {
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
        super.prepareForReuse()
    }
}
