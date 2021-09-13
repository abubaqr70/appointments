// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilityDetail {
    
    var staff : [FacilityStaffDetail]!

       /**
        * Instantiate the instance using the passed json values to set the properties values
        */
       init(fromJson json: JSON!){
           if json.isEmpty{
               return
           }
           staff = [FacilityStaffDetail]()
           let staffArray = json["staff"].arrayValue
           for staffJson in staffArray{
               let value = FacilityStaffDetail(fromJson: staffJson)
               staff.append(value)
           }
       }

}
