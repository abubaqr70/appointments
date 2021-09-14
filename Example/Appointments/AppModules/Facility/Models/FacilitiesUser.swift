// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct FacilitiesUser : Codable {
    
	let v_workphone : String?
	let v_favorite_snacks : String?
	let v_state : String?
	let i_last_updated : Int?
	let fk_education_id : String?
	let v_occupation : String?
	let t_note : String?
	let v_favorite_desert : String?
	let fullname : String?
	let v_reminders_enabled : String?
	let v_phone : String?
	let i_discharge_date : String?
	let t_evening_activities : String?
	let initials : String?
	let v_mobility : String?
	let v_blood_type : String?
	let i_disclaimer : Int?
	let occupation : String?
	let fk_facility_id : String?
	let profileImageRoute : String?
	let v_npi : String?
	let gender : String?
	let v_first_name : String?
	let i_last_login_date : Int?
	let v_country : String?
	let id : Int?
	let i_do_not_mail : String?
	let v_preferred_mailing_location : String?
	let v_fax : String?
	let b_picture_resized : Bool?
	let i_admission_date : String?
	let passwordChangedDuration : String?
	let thumbnail : String?
	let i_created : Int?
	let v_favorite_sports_team : String?
	let v_dea : String?
	let formattedAdmissionDate : String?
	let imageResized : Bool?
	let i_is_archived : Int?
	let v_preferred_location : String?
	let i_picture_last_updated : String?
	let fk_invited_by_id : Int?
	let t_noon_activities : String?
	let v_gender : String?
	let i_login_count : Int?
	let fk_updated_by_id : Int?
	let admission_date : String?
	let specialty : String?
	let fk_military_service_id : String?
	let i_aup_date : String?
	let i_status : Int?
	let fk_mdl_user_id : String?
	let v_favorite_sport : String?
	let v_last_name : String?
	let v_mrn : String?
	let v_room_no : String?
	let fk_language_id : String?
	let i_last_password_changed : Int?
	let imageContent : String?
	let v_username : String?
	let i_date_of_birth : String?
	let v_avoid_food : String?
	let fk_ethnicity_id : Int?
	let v_ssn : String?
	let v_invitation_signature : String?
	let v_external_id : String?
	let v_picture : String?
	let i_do_not_email : String?
	let v_membership : String?
	let fk_tenant_id : Int?
	let v_api_key : String?
	let dOB : String?
	let v_mobile : String?
	let v_title : String?
	let v_code_status : String?
	let fk_religion_id : String?
	let fk_secondary_language_id : String?
	let subspecialty : String?
	let i_do_not_call : String?
	let v_invitation_expiry_date : String?
	let v_broadcast_enabled : String?
	let i_dob : String?
	let fk_marital_status_id : Int?
	let v_city : String?
	let t_morning_activities : String?
	let v_address1 : String?
	let v_address2 : String?
	let t_favorite_past_time : String?
	let full_name : String?
	let v_email : String?
	let v_role_title : String?
	let v_zip : String?
	let i_api_timestamp : Int?
	let v_favorite_drink : String?
	let fk_care_location_id : Int?

	enum CodingKeys: String, CodingKey {

		case v_workphone = "v_workphone"
		case v_favorite_snacks = "v_favorite_snacks"
		case v_state = "v_state"
		case i_last_updated = "i_last_updated"
		case fk_education_id = "fk_education_id"
		case v_occupation = "v_occupation"
		case t_note = "t_note"
		case v_favorite_desert = "v_favorite_desert"
		case fullname = "fullname"
		case v_reminders_enabled = "v_reminders_enabled"
		case v_phone = "v_phone"
		case i_discharge_date = "i_discharge_date"
		case t_evening_activities = "t_evening_activities"
		case initials = "initials"
		case v_mobility = "v_mobility"
		case v_blood_type = "v_blood_type"
		case i_disclaimer = "i_disclaimer"
		case occupation = "occupation"
		case fk_facility_id = "fk_facility_id"
		case profileImageRoute = "profileImageRoute"
		case v_npi = "v_npi"
		case gender = "gender"
		case v_first_name = "v_first_name"
		case i_last_login_date = "i_last_login_date"
		case v_country = "v_country"
		case id = "id"
		case i_do_not_mail = "i_do_not_mail"
		case v_preferred_mailing_location = "v_preferred_mailing_location"
		case v_fax = "v_fax"
		case b_picture_resized = "b_picture_resized"
		case i_admission_date = "i_admission_date"
		case passwordChangedDuration = "passwordChangedDuration"
		case thumbnail = "thumbnail"
		case i_created = "i_created"
		case v_favorite_sports_team = "v_favorite_sports_team"
		case v_dea = "v_dea"
		case formattedAdmissionDate = "formattedAdmissionDate"
		case imageResized = "imageResized"
		case i_is_archived = "i_is_archived"
		case v_preferred_location = "v_preferred_location"
		case i_picture_last_updated = "i_picture_last_updated"
		case fk_invited_by_id = "fk_invited_by_id"
		case t_noon_activities = "t_noon_activities"
		case v_gender = "v_gender"
		case i_login_count = "i_login_count"
		case fk_updated_by_id = "fk_updated_by_id"
		case admission_date = "admission_date"
		case specialty = "specialty"
		case fk_military_service_id = "fk_military_service_id"
		case i_aup_date = "i_aup_date"
		case i_status = "i_status"
		case fk_mdl_user_id = "fk_mdl_user_id"
		case v_favorite_sport = "v_favorite_sport"
		case v_last_name = "v_last_name"
		case v_mrn = "v_mrn"
		case v_room_no = "v_room_no"
		case fk_language_id = "fk_language_id"
		case i_last_password_changed = "i_last_password_changed"
		case imageContent = "imageContent"
		case v_username = "v_username"
		case i_date_of_birth = "i_date_of_birth"
		case v_avoid_food = "v_avoid_food"
		case fk_ethnicity_id = "fk_ethnicity_id"
		case v_ssn = "v_ssn"
		case v_invitation_signature = "v_invitation_signature"
		case v_external_id = "v_external_id"
		case v_picture = "v_picture"
		case i_do_not_email = "i_do_not_email"
		case v_membership = "v_membership"
		case fk_tenant_id = "fk_tenant_id"
		case v_api_key = "v_api_key"
		case dOB = "DOB"
		case v_mobile = "v_mobile"
		case v_title = "v_title"
		case v_code_status = "v_code_status"
		case fk_religion_id = "fk_religion_id"
		case fk_secondary_language_id = "fk_secondary_language_id"
		case subspecialty = "subspecialty"
		case i_do_not_call = "i_do_not_call"
		case v_invitation_expiry_date = "v_invitation_expiry_date"
		case v_broadcast_enabled = "v_broadcast_enabled"
		case i_dob = "i_dob"
		case fk_marital_status_id = "fk_marital_status_id"
		case v_city = "v_city"
		case t_morning_activities = "t_morning_activities"
		case v_address1 = "v_address1"
		case v_address2 = "v_address2"
		case t_favorite_past_time = "t_favorite_past_time"
		case full_name = "full_name"
		case v_email = "v_email"
		case v_role_title = "v_role_title"
		case v_zip = "v_zip"
		case i_api_timestamp = "i_api_timestamp"
		case v_favorite_drink = "v_favorite_drink"
		case fk_care_location_id = "fk_care_location_id"
	}

}

extension FacilitiesUser {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        v_workphone = try values.decodeIfPresent(String.self, forKey: .v_workphone)
        v_favorite_snacks = try values.decodeIfPresent(String.self, forKey: .v_favorite_snacks)
        v_state = try values.decodeIfPresent(String.self, forKey: .v_state)
        i_last_updated = try values.decodeIfPresent(Int.self, forKey: .i_last_updated)
        fk_education_id = try values.decodeIfPresent(String.self, forKey: .fk_education_id)
        v_occupation = try values.decodeIfPresent(String.self, forKey: .v_occupation)
        t_note = try values.decodeIfPresent(String.self, forKey: .t_note)
        v_favorite_desert = try values.decodeIfPresent(String.self, forKey: .v_favorite_desert)
        fullname = try values.decodeIfPresent(String.self, forKey: .fullname)
        v_reminders_enabled = try values.decodeIfPresent(String.self, forKey: .v_reminders_enabled)
        v_phone = try values.decodeIfPresent(String.self, forKey: .v_phone)
        i_discharge_date = try values.decodeIfPresent(String.self, forKey: .i_discharge_date)
        t_evening_activities = try values.decodeIfPresent(String.self, forKey: .t_evening_activities)
        initials = try values.decodeIfPresent(String.self, forKey: .initials)
        v_mobility = try values.decodeIfPresent(String.self, forKey: .v_mobility)
        v_blood_type = try values.decodeIfPresent(String.self, forKey: .v_blood_type)
        i_disclaimer = try values.decodeIfPresent(Int.self, forKey: .i_disclaimer)
        occupation = try values.decodeIfPresent(String.self, forKey: .occupation)
        fk_facility_id = try values.decodeIfPresent(String.self, forKey: .fk_facility_id)
        profileImageRoute = try values.decodeIfPresent(String.self, forKey: .profileImageRoute)
        v_npi = try values.decodeIfPresent(String.self, forKey: .v_npi)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        v_first_name = try values.decodeIfPresent(String.self, forKey: .v_first_name)
        i_last_login_date = try values.decodeIfPresent(Int.self, forKey: .i_last_login_date)
        v_country = try values.decodeIfPresent(String.self, forKey: .v_country)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        i_do_not_mail = try values.decodeIfPresent(String.self, forKey: .i_do_not_mail)
        v_preferred_mailing_location = try values.decodeIfPresent(String.self, forKey: .v_preferred_mailing_location)
        v_fax = try values.decodeIfPresent(String.self, forKey: .v_fax)
        b_picture_resized = try values.decodeIfPresent(Bool.self, forKey: .b_picture_resized)
        i_admission_date = try values.decodeIfPresent(String.self, forKey: .i_admission_date)
        passwordChangedDuration = try values.decodeIfPresent(String.self, forKey: .passwordChangedDuration)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        i_created = try values.decodeIfPresent(Int.self, forKey: .i_created)
        v_favorite_sports_team = try values.decodeIfPresent(String.self, forKey: .v_favorite_sports_team)
        v_dea = try values.decodeIfPresent(String.self, forKey: .v_dea)
        formattedAdmissionDate = try values.decodeIfPresent(String.self, forKey: .formattedAdmissionDate)
        imageResized = try values.decodeIfPresent(Bool.self, forKey: .imageResized)
        i_is_archived = try values.decodeIfPresent(Int.self, forKey: .i_is_archived)
        v_preferred_location = try values.decodeIfPresent(String.self, forKey: .v_preferred_location)
        i_picture_last_updated = try values.decodeIfPresent(String.self, forKey: .i_picture_last_updated)
        fk_invited_by_id = try values.decodeIfPresent(Int.self, forKey: .fk_invited_by_id)
        t_noon_activities = try values.decodeIfPresent(String.self, forKey: .t_noon_activities)
        v_gender = try values.decodeIfPresent(String.self, forKey: .v_gender)
        i_login_count = try values.decodeIfPresent(Int.self, forKey: .i_login_count)
        fk_updated_by_id = try values.decodeIfPresent(Int.self, forKey: .fk_updated_by_id)
        admission_date = try values.decodeIfPresent(String.self, forKey: .admission_date)
        specialty = try values.decodeIfPresent(String.self, forKey: .specialty)
        fk_military_service_id = try values.decodeIfPresent(String.self, forKey: .fk_military_service_id)
        i_aup_date = try values.decodeIfPresent(String.self, forKey: .i_aup_date)
        i_status = try values.decodeIfPresent(Int.self, forKey: .i_status)
        fk_mdl_user_id = try values.decodeIfPresent(String.self, forKey: .fk_mdl_user_id)
        v_favorite_sport = try values.decodeIfPresent(String.self, forKey: .v_favorite_sport)
        v_last_name = try values.decodeIfPresent(String.self, forKey: .v_last_name)
        v_mrn = try values.decodeIfPresent(String.self, forKey: .v_mrn)
        v_room_no = try values.decodeIfPresent(String.self, forKey: .v_room_no)
        fk_language_id = try values.decodeIfPresent(String.self, forKey: .fk_language_id)
        i_last_password_changed = try values.decodeIfPresent(Int.self, forKey: .i_last_password_changed)
        imageContent = try values.decodeIfPresent(String.self, forKey: .imageContent)
        v_username = try values.decodeIfPresent(String.self, forKey: .v_username)
        i_date_of_birth = try values.decodeIfPresent(String.self, forKey: .i_date_of_birth)
        v_avoid_food = try values.decodeIfPresent(String.self, forKey: .v_avoid_food)
        fk_ethnicity_id = try values.decodeIfPresent(Int.self, forKey: .fk_ethnicity_id)
        v_ssn = try values.decodeIfPresent(String.self, forKey: .v_ssn)
        v_invitation_signature = try values.decodeIfPresent(String.self, forKey: .v_invitation_signature)
        v_external_id = try values.decodeIfPresent(String.self, forKey: .v_external_id)
        v_picture = try values.decodeIfPresent(String.self, forKey: .v_picture)
        i_do_not_email = try values.decodeIfPresent(String.self, forKey: .i_do_not_email)
        v_membership = try values.decodeIfPresent(String.self, forKey: .v_membership)
        fk_tenant_id = try values.decodeIfPresent(Int.self, forKey: .fk_tenant_id)
        v_api_key = try values.decodeIfPresent(String.self, forKey: .v_api_key)
        dOB = try values.decodeIfPresent(String.self, forKey: .dOB)
        v_mobile = try values.decodeIfPresent(String.self, forKey: .v_mobile)
        v_title = try values.decodeIfPresent(String.self, forKey: .v_title)
        v_code_status = try values.decodeIfPresent(String.self, forKey: .v_code_status)
        fk_religion_id = try values.decodeIfPresent(String.self, forKey: .fk_religion_id)
        fk_secondary_language_id = try values.decodeIfPresent(String.self, forKey: .fk_secondary_language_id)
        subspecialty = try values.decodeIfPresent(String.self, forKey: .subspecialty)
        i_do_not_call = try values.decodeIfPresent(String.self, forKey: .i_do_not_call)
        v_invitation_expiry_date = try values.decodeIfPresent(String.self, forKey: .v_invitation_expiry_date)
        v_broadcast_enabled = try values.decodeIfPresent(String.self, forKey: .v_broadcast_enabled)
        i_dob = try values.decodeIfPresent(String.self, forKey: .i_dob)
        fk_marital_status_id = try values.decodeIfPresent(Int.self, forKey: .fk_marital_status_id)
        v_city = try values.decodeIfPresent(String.self, forKey: .v_city)
        t_morning_activities = try values.decodeIfPresent(String.self, forKey: .t_morning_activities)
        v_address1 = try values.decodeIfPresent(String.self, forKey: .v_address1)
        v_address2 = try values.decodeIfPresent(String.self, forKey: .v_address2)
        t_favorite_past_time = try values.decodeIfPresent(String.self, forKey: .t_favorite_past_time)
        full_name = try values.decodeIfPresent(String.self, forKey: .full_name)
        v_email = try values.decodeIfPresent(String.self, forKey: .v_email)
        v_role_title = try values.decodeIfPresent(String.self, forKey: .v_role_title)
        v_zip = try values.decodeIfPresent(String.self, forKey: .v_zip)
        i_api_timestamp = try values.decodeIfPresent(Int.self, forKey: .i_api_timestamp)
        v_favorite_drink = try values.decodeIfPresent(String.self, forKey: .v_favorite_drink)
        fk_care_location_id = try values.decodeIfPresent(Int.self, forKey: .fk_care_location_id)
    }

}
