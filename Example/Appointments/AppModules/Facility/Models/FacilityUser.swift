// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilityUser {
    
    var admissionDate : String!
    var bPictureResized : Bool!
    var dOB : String!
    var fkCareLocationId : Int!
    var fkEducationId : String!
    var fkEthnicityId : Int!
    var fkFacilityId : String!
    var fkInvitedById : Int!
    var fkLanguageId : String!
    var fkMaritalStatusId : Int!
    var fkMdlUserId : String!
    var fkMilitaryServiceId : String!
    var fkReligionId : String!
    var fkSecondaryLanguageId : String!
    var fkTenantId : Int!
    var fkUpdatedById : Int!
    var formattedAdmissionDate : String!
    var fullName : String!
    var fullname : String!
    var gender : String!
    var iAdmissionDate : String!
    var iApiTimestamp : Int!
    var iAupDate : String!
    var iCreated : Int!
    var iDateOfBirth : String!
    var iDischargeDate : String!
    var iDisclaimer : Int!
    var iDoNotCall : String!
    var iDoNotEmail : String!
    var iDoNotMail : String!
    var iDob : String!
    var iIsArchived : Int!
    var iLastLoginDate : Int!
    var iLastPasswordChanged : Int!
    var iLastUpdated : Int!
    var iLoginCount : Int!
    var iPictureLastUpdated : String!
    var iStatus : Int!
    var id : Int!
    var imageContent : String!
    var imageResized : Bool!
    var initials : String!
    var occupation : String!
    var passwordChangedDuration : String!
    var profileImageRoute : String!
    var specialty : String!
    var subspecialty : String!
    var tEveningActivities : String!
    var tFavoritePastTime : String!
    var tMorningActivities : String!
    var tNoonActivities : String!
    var tNote : String!
    var thumbnail : String!
    var vAddress1 : String!
    var vAddress2 : String!
    var vApiKey : String!
    var vAvoidFood : String!
    var vBloodType : String!
    var vBroadcastEnabled : String!
    var vCity : String!
    var vCodeStatus : String!
    var vCountry : String!
    var vDea : String!
    var vEmail : String!
    var vExternalId : String!
    var vFavoriteDesert : String!
    var vFavoriteDrink : String!
    var vFavoriteSnacks : String!
    var vFavoriteSport : String!
    var vFavoriteSportsTeam : String!
    var vFax : String!
    var vFirstName : String!
    var vGender : String!
    var vInvitationExpiryDate : String!
    var vInvitationSignature : String!
    var vLastName : String!
    var vMembership : String!
    var vMobile : String!
    var vMobility : String!
    var vMrn : String!
    var vNpi : String!
    var vOccupation : String!
    var vPhone : String!
    var vPicture : String!
    var vPreferredLocation : String!
    var vPreferredMailingLocation : String!
    var vRemindersEnabled : String!
    var vRoleTitle : String!
    var vRoomNo : String!
    var vSsn : String!
    var vState : String!
    var vTitle : String!
    var vUsername : String!
    var vWorkphone : String!
    var vZip : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        admissionDate = json["admission_date"].stringValue
        bPictureResized = json["b_picture_resized"].boolValue
        dOB = json["DOB"].stringValue
        fkCareLocationId = json["fk_care_location_id"].intValue
        fkEducationId = json["fk_education_id"].stringValue
        fkEthnicityId = json["fk_ethnicity_id"].intValue
        fkFacilityId = json["fk_facility_id"].stringValue
        fkInvitedById = json["fk_invited_by_id"].intValue
        fkLanguageId = json["fk_language_id"].stringValue
        fkMaritalStatusId = json["fk_marital_status_id"].intValue
        fkMdlUserId = json["fk_mdl_user_id"].stringValue
        fkMilitaryServiceId = json["fk_military_service_id"].stringValue
        fkReligionId = json["fk_religion_id"].stringValue
        fkSecondaryLanguageId = json["fk_secondary_language_id"].stringValue
        fkTenantId = json["fk_tenant_id"].intValue
        fkUpdatedById = json["fk_updated_by_id"].intValue
        formattedAdmissionDate = json["formattedAdmissionDate"].stringValue
        fullName = json["full_name"].stringValue
        fullname = json["fullname"].stringValue
        gender = json["gender"].stringValue
        iAdmissionDate = json["i_admission_date"].stringValue
        iApiTimestamp = json["i_api_timestamp"].intValue
        iAupDate = json["i_aup_date"].stringValue
        iCreated = json["i_created"].intValue
        iDateOfBirth = json["i_date_of_birth"].stringValue
        iDischargeDate = json["i_discharge_date"].stringValue
        iDisclaimer = json["i_disclaimer"].intValue
        iDoNotCall = json["i_do_not_call"].stringValue
        iDoNotEmail = json["i_do_not_email"].stringValue
        iDoNotMail = json["i_do_not_mail"].stringValue
        iDob = json["i_dob"].stringValue
        iIsArchived = json["i_is_archived"].intValue
        iLastLoginDate = json["i_last_login_date"].intValue
        iLastPasswordChanged = json["i_last_password_changed"].intValue
        iLastUpdated = json["i_last_updated"].intValue
        iLoginCount = json["i_login_count"].intValue
        iPictureLastUpdated = json["i_picture_last_updated"].stringValue
        iStatus = json["i_status"].intValue
        id = json["id"].intValue
        imageContent = json["imageContent"].stringValue
        imageResized = json["imageResized"].boolValue
        initials = json["initials"].stringValue
        occupation = json["occupation"].stringValue
        passwordChangedDuration = json["passwordChangedDuration"].stringValue
        profileImageRoute = json["profileImageRoute"].stringValue
        specialty = json["specialty"].stringValue
        subspecialty = json["subspecialty"].stringValue
        tEveningActivities = json["t_evening_activities"].stringValue
        tFavoritePastTime = json["t_favorite_past_time"].stringValue
        tMorningActivities = json["t_morning_activities"].stringValue
        tNoonActivities = json["t_noon_activities"].stringValue
        tNote = json["t_note"].stringValue
        thumbnail = json["thumbnail"].stringValue
        vAddress1 = json["v_address1"].stringValue
        vAddress2 = json["v_address2"].stringValue
        vApiKey = json["v_api_key"].stringValue
        vAvoidFood = json["v_avoid_food"].stringValue
        vBloodType = json["v_blood_type"].stringValue
        vBroadcastEnabled = json["v_broadcast_enabled"].stringValue
        vCity = json["v_city"].stringValue
        vCodeStatus = json["v_code_status"].stringValue
        vCountry = json["v_country"].stringValue
        vDea = json["v_dea"].stringValue
        vEmail = json["v_email"].stringValue
        vExternalId = json["v_external_id"].stringValue
        vFavoriteDesert = json["v_favorite_desert"].stringValue
        vFavoriteDrink = json["v_favorite_drink"].stringValue
        vFavoriteSnacks = json["v_favorite_snacks"].stringValue
        vFavoriteSport = json["v_favorite_sport"].stringValue
        vFavoriteSportsTeam = json["v_favorite_sports_team"].stringValue
        vFax = json["v_fax"].stringValue
        vFirstName = json["v_first_name"].stringValue
        vGender = json["v_gender"].stringValue
        vInvitationExpiryDate = json["v_invitation_expiry_date"].stringValue
        vInvitationSignature = json["v_invitation_signature"].stringValue
        vLastName = json["v_last_name"].stringValue
        vMembership = json["v_membership"].stringValue
        vMobile = json["v_mobile"].stringValue
        vMobility = json["v_mobility"].stringValue
        vMrn = json["v_mrn"].stringValue
        vNpi = json["v_npi"].stringValue
        vOccupation = json["v_occupation"].stringValue
        vPhone = json["v_phone"].stringValue
        vPicture = json["v_picture"].stringValue
        vPreferredLocation = json["v_preferred_location"].stringValue
        vPreferredMailingLocation = json["v_preferred_mailing_location"].stringValue
        vRemindersEnabled = json["v_reminders_enabled"].stringValue
        vRoleTitle = json["v_role_title"].stringValue
        vRoomNo = json["v_room_no"].stringValue
        vSsn = json["v_ssn"].stringValue
        vState = json["v_state"].stringValue
        vTitle = json["v_title"].stringValue
        vUsername = json["v_username"].stringValue
        vWorkphone = json["v_workphone"].stringValue
        vZip = json["v_zip"].stringValue
    }
    
}
