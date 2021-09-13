// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct Facility {
    var authorization : FacilityAuthorization!
    var authorizedPreAdmitted : [Int]!
    var authorizedResidents : [FacilityAuthorizedResident]!
    var authorizedUsers : [Int]!
    var emarConfigs : FacilityEmarConfig!
    var featureFlags : [String]!
    var fkTenantId : Int!
    var iIpSecurity : Bool!
    var iIsDeactivated : Bool!
    var iMaxBed : Int!
    var iRecordDrg : Bool!
    var iShowActivitiesFamilyApp : Bool!
    var iShowAdlFamilyApp : Bool!
    var id : Int!
    var isCollaborator : Bool!
    var permissions : [FacilityPermission]!
    var roles : [FacilityRole]!
    var shifts : [FacilityShift]!
    var staff : [FacilityStaff]!
    var subWebapps : [FacilitySubWebapp]!
    var tags : [FacilityTag]!
    var timezoneKey : String!
    var userPasswordExpiryLimit : Int!
    var vAbbreviation : String!
    var vAddress : String!
    var vAddress2 : String!
    var vCity : String!
    var vCountry : String!
    var vEmail : String!
    var vFacilityType : String!
    var vName : String!
    var vPhone : String!
    var vState : String!
    var vTimezoneKey : String!
    var vZip : String!
    var webapps : [FacilityWebapp]!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let authorizationJson = json["authorization"]
        if !authorizationJson.isEmpty{
            authorization = FacilityAuthorization(fromJson: authorizationJson)
        }
        authorizedPreAdmitted = [Int]()
        let authorizedPreAdmittedArray = json["authorized_pre_admitted"].arrayValue
        for authorizedPreAdmittedJson in authorizedPreAdmittedArray{
            authorizedPreAdmitted.append(authorizedPreAdmittedJson.intValue)
        }
        authorizedResidents = [FacilityAuthorizedResident]()
        let authorizedResidentsArray = json["authorized_residents"].arrayValue
        for authorizedResidentsJson in authorizedResidentsArray{
            let value = FacilityAuthorizedResident(fromJson: authorizedResidentsJson)
            authorizedResidents.append(value)
        }
        authorizedUsers = [Int]()
        let authorizedUsersArray = json["authorized_users"].arrayValue
        for authorizedUsersJson in authorizedUsersArray{
            authorizedUsers.append(authorizedUsersJson.intValue)
        }
        let emarConfigsJson = json["emar_configs"]
        if !emarConfigsJson.isEmpty{
            emarConfigs = FacilityEmarConfig(fromJson: emarConfigsJson)
        }
        featureFlags = [String]()
        let featureFlagsArray = json["featureFlags"].arrayValue
        for featureFlagsJson in featureFlagsArray{
            featureFlags.append(featureFlagsJson.stringValue)
        }
        fkTenantId = json["fk_tenant_id"].intValue
        iIpSecurity = json["i_ip_security"].boolValue
        iIsDeactivated = json["i_is_deactivated"].boolValue
        iMaxBed = json["i_max_bed"].intValue
        iRecordDrg = json["i_record_drg"].boolValue
        iShowActivitiesFamilyApp = json["i_show_activities_family_app"].boolValue
        iShowAdlFamilyApp = json["i_show_adl_family_app"].boolValue
        id = json["id"].intValue
        isCollaborator = json["is_collaborator"].boolValue
        permissions = [FacilityPermission]()
        let permissionsArray = json["permissions"].arrayValue
        for permissionsJson in permissionsArray{
            let value = FacilityPermission(fromJson: permissionsJson)
            permissions.append(value)
        }
        roles = [FacilityRole]()
        let rolesArray = json["roles"].arrayValue
        for rolesJson in rolesArray{
            let value = FacilityRole(fromJson: rolesJson)
            roles.append(value)
        }
        shifts = [FacilityShift]()
        let shiftsArray = json["shifts"].arrayValue
        for shiftsJson in shiftsArray{
            let value = FacilityShift(fromJson: shiftsJson)
            shifts.append(value)
        }
        staff = [FacilityStaff]()
        let staffArray = json["staff"].arrayValue
        for staffJson in staffArray{
            let value = FacilityStaff(fromJson: staffJson)
            staff.append(value)
        }
        subWebapps = [FacilitySubWebapp]()
        let subWebappsArray = json["subWebapps"].arrayValue
        for subWebappsJson in subWebappsArray{
            let value = FacilitySubWebapp(fromJson: subWebappsJson)
            subWebapps.append(value)
        }
        tags = [FacilityTag]()
        let tagsArray = json["tags"].arrayValue
        for tagsJson in tagsArray{
            let value = FacilityTag(fromJson: tagsJson)
            tags.append(value)
        }
        timezoneKey = json["timezoneKey"].stringValue
        userPasswordExpiryLimit = json["user_password_expiry_limit"].intValue
        vAbbreviation = json["v_abbreviation"].stringValue
        vAddress = json["v_address"].stringValue
        vAddress2 = json["v_address2"].stringValue
        vCity = json["v_city"].stringValue
        vCountry = json["v_country"].stringValue
        vEmail = json["v_email"].stringValue
        vFacilityType = json["v_facility_type"].stringValue
        vName = json["v_name"].stringValue
        vPhone = json["v_phone"].stringValue
        vState = json["v_state"].stringValue
        vTimezoneKey = json["v_timezone_key"].stringValue
        vZip = json["v_zip"].stringValue
        webapps = [FacilityWebapp]()
        let webappsArray = json["webapps"].arrayValue
        for webappsJson in webappsArray{
            let value = FacilityWebapp(fromJson: webappsJson)
            webapps.append(value)
        }
    }
    
}
