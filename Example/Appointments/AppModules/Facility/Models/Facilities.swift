// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Facilities : Codable {
    
	let v_abbreviation : String?
	let i_ip_security : Bool?
	let authorized_pre_admitted : [Int]?
	let v_zip : String?
	let v_state : String?
	let timezoneKey : String?
	let authorized_residents : [Authorized_residents]?
	let authorized_users : [Int]?
	let i_max_bed : Int?
	let v_email : String?
	let subWebapps : [SubWebapps]?
	let id : Int?
	let is_collaborator : Bool?
	let v_address : String?
	let i_show_adl_family_app : Bool?
	let v_city : String?
	let authorization : Authorization?
	let tags : [Tags]?
	let emar_configs : Emar_configs?
	let v_address2 : String?
	let staff : [Staff]?
	let featureFlags : [String]?
	let user_password_expiry_limit : Int?
	let fk_tenant_id : Int?
	let i_record_drg : Bool?
	let i_is_deactivated : Bool?
	let v_country : String?
	let permissions : [Permissions]?
	let v_phone : String?
	let v_name : String?
	let v_timezone_key : String?
	let shifts : [Shifts]?
	let i_show_activities_family_app : Bool?
	let roles : [Roles]?
	let v_facility_type : String?

	enum CodingKeys: String, CodingKey {

		case v_abbreviation = "v_abbreviation"
		case i_ip_security = "i_ip_security"
		case authorized_pre_admitted = "authorized_pre_admitted"
		case v_zip = "v_zip"
		case v_state = "v_state"
		case timezoneKey = "timezoneKey"
		case authorized_residents = "authorized_residents"
		case authorized_users = "authorized_users"
		case i_max_bed = "i_max_bed"
		case v_email = "v_email"
		case subWebapps = "subWebapps"
		case id = "id"
		case is_collaborator = "is_collaborator"
		case v_address = "v_address"
		case i_show_adl_family_app = "i_show_adl_family_app"
		case v_city = "v_city"
		case authorization = "authorization"
		case tags = "tags"
		case emar_configs = "emar_configs"
		case v_address2 = "v_address2"
		case staff = "staff"
		case featureFlags = "featureFlags"
		case user_password_expiry_limit = "user_password_expiry_limit"
		case fk_tenant_id = "fk_tenant_id"
		case i_record_drg = "i_record_drg"
		case i_is_deactivated = "i_is_deactivated"
		case v_country = "v_country"
		case permissions = "permissions"
		case v_phone = "v_phone"
		case v_name = "v_name"
		case v_timezone_key = "v_timezone_key"
		case shifts = "shifts"
		case i_show_activities_family_app = "i_show_activities_family_app"
		case roles = "roles"
		case v_facility_type = "v_facility_type"
	}

}

extension Facilities {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        v_abbreviation = try values.decodeIfPresent(String.self, forKey: .v_abbreviation)
        i_ip_security = try values.decodeIfPresent(Bool.self, forKey: .i_ip_security)
        authorized_pre_admitted = try values.decodeIfPresent([Int].self, forKey: .authorized_pre_admitted)
        v_zip = try values.decodeIfPresent(String.self, forKey: .v_zip)
        v_state = try values.decodeIfPresent(String.self, forKey: .v_state)
        timezoneKey = try values.decodeIfPresent(String.self, forKey: .timezoneKey)
        authorized_residents = try values.decodeIfPresent([Authorized_residents].self, forKey: .authorized_residents)
        authorized_users = try values.decodeIfPresent([Int].self, forKey: .authorized_users)
        i_max_bed = try values.decodeIfPresent(Int.self, forKey: .i_max_bed)
        v_email = try values.decodeIfPresent(String.self, forKey: .v_email)
        subWebapps = try values.decodeIfPresent([SubWebapps].self, forKey: .subWebapps)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        is_collaborator = try values.decodeIfPresent(Bool.self, forKey: .is_collaborator)
        v_address = try values.decodeIfPresent(String.self, forKey: .v_address)
        i_show_adl_family_app = try values.decodeIfPresent(Bool.self, forKey: .i_show_adl_family_app)
        v_city = try values.decodeIfPresent(String.self, forKey: .v_city)
        authorization = try values.decodeIfPresent(Authorization.self, forKey: .authorization)
        tags = try values.decodeIfPresent([Tags].self, forKey: .tags)
        emar_configs = try values.decodeIfPresent(Emar_configs.self, forKey: .emar_configs)
        v_address2 = try values.decodeIfPresent(String.self, forKey: .v_address2)
        staff = try values.decodeIfPresent([Staff].self, forKey: .staff)
        featureFlags = try values.decodeIfPresent([String].self, forKey: .featureFlags)
        user_password_expiry_limit = try values.decodeIfPresent(Int.self, forKey: .user_password_expiry_limit)
        fk_tenant_id = try values.decodeIfPresent(Int.self, forKey: .fk_tenant_id)
        i_record_drg = try values.decodeIfPresent(Bool.self, forKey: .i_record_drg)
        i_is_deactivated = try values.decodeIfPresent(Bool.self, forKey: .i_is_deactivated)
        v_country = try values.decodeIfPresent(String.self, forKey: .v_country)
        permissions = try values.decodeIfPresent([Permissions].self, forKey: .permissions)
        v_phone = try values.decodeIfPresent(String.self, forKey: .v_phone)
        v_name = try values.decodeIfPresent(String.self, forKey: .v_name)
        v_timezone_key = try values.decodeIfPresent(String.self, forKey: .v_timezone_key)
        shifts = try values.decodeIfPresent([Shifts].self, forKey: .shifts)
        i_show_activities_family_app = try values.decodeIfPresent(Bool.self, forKey: .i_show_activities_family_app)
        roles = try values.decodeIfPresent([Roles].self, forKey: .roles)
        v_facility_type = try values.decodeIfPresent(String.self, forKey: .v_facility_type)
    }

}
