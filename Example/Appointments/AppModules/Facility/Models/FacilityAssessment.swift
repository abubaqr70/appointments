// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilityAssessment{
    
    var canAdd : Bool!
    var canAddV1 : Bool!
    var canDelete : Bool!
    var canEdit : Bool!
    var canEditV1 : Bool!
    var canManage : Bool!
    var canManageV1 : Bool!
    var canOverrideLock : Bool!
    var canUpload : Bool!
    var canView : Bool!
    var canViewOrManage : Bool!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        canAdd = json["canAdd"].boolValue
        canAddV1 = json["canAddV1"].boolValue
        canDelete = json["canDelete"].boolValue
        canEdit = json["canEdit"].boolValue
        canEditV1 = json["canEditV1"].boolValue
        canManage = json["canManage"].boolValue
        canManageV1 = json["canManageV1"].boolValue
        canOverrideLock = json["canOverrideLock"].boolValue
        canUpload = json["canUpload"].boolValue
        canView = json["canView"].boolValue
        canViewOrManage = json["canViewOrManage"].boolValue
    }

}
