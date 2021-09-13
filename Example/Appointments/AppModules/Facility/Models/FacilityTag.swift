// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilityTag {
    var fkFacilityId : Int!
    var iArchived : String!
    var iShowInFamilyApp : Int!
    var iShowInNotesApp : Int!
    var iShowInTodosApp : Int!
    var iStatus : Int!
    var id : Int!
    var levels : [FacilityLevel]!
    var parentFacilityId : Int!
    var vActionClause : String!
    var vActionClauseTodos : String!
    var vActionStructure : String!
    var vName : String!
    var vType : Int!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        fkFacilityId = json["fk_facility_id"].intValue
        iArchived = json["i_archived"].stringValue
        iShowInFamilyApp = json["i_show_in_family_app"].intValue
        iShowInNotesApp = json["i_show_in_notes_app"].intValue
        iShowInTodosApp = json["i_show_in_todos_app"].intValue
        iStatus = json["i_status"].intValue
        id = json["id"].intValue
        levels = [FacilityLevel]()
        let levelsArray = json["levels"].arrayValue
        for levelsJson in levelsArray{
            let value = FacilityLevel(fromJson: levelsJson)
            levels.append(value)
        }
        parentFacilityId = json["parentFacilityId"].intValue
        vActionClause = json["v_action_clause"].stringValue
        vActionClauseTodos = json["v_action_clause_todos"].stringValue
        vActionStructure = json["v_action_structure"].stringValue
        vName = json["v_name"].stringValue
        vType = json["v_type"].intValue
    }
    
}
