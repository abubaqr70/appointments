// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxSwift

class FacilityListCell: UITableViewCell {

    @IBOutlet weak var facilityName: UILabel!
    @IBOutlet weak var facilityAddress: UILabel!
    
    let disposeBag = DisposeBag()
    let facility = PublishSubject<Facilities>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        facility.map({
            facility in
            facility.v_name
        }).bind(to: facilityName.rx.text).disposed(by: disposeBag)
        
        facility.map({
            facility in
            "\(facility.v_city ?? ""), \(facility.v_state ?? "")"
        }).bind(to: facilityAddress.rx.text).disposed(by: disposeBag)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    
}
