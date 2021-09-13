// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilityFamily {
    
    var canAddMessages : Bool!
    var canManageFamilyAnnouncements : Bool!
    var canViewFamilyNPSSurvey : Bool!
    var canViewMessages : Bool!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        canAddMessages = json["canAddMessages"].boolValue
        canManageFamilyAnnouncements = json["canManageFamilyAnnouncements"].boolValue
        canViewFamilyNPSSurvey = json["canViewFamilyNPSSurvey"].boolValue
        canViewMessages = json["canViewMessages"].boolValue
    }

}
