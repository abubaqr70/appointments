// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxSwift
import SwiftyJSON

class FacilityListCell: UITableViewCell {

    @IBOutlet weak var facilityName: UILabel!
    @IBOutlet weak var facilityAddress: UILabel!
    
    let disposeBag = DisposeBag()
    let facility = BehaviorSubject<Facility>(value: Facility(fromJson: JSON()))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        facility.map({
            facility in
            facility.vName
        }).bind(to: facilityName.rx.text).disposed(by: disposeBag)
        
        facility.map({
            facility in
            "\(facility.vCity ?? ""), \(facility.vState ?? "")"
        }).bind(to: facilityAddress.rx.text).disposed(by: disposeBag)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    
}
