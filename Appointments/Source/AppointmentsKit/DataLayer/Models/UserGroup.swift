// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct UserGroup : Codable {
	let facilityCategory : FacilityCategory?
	let facilityGroupMembers : [FacilityGroupMembers]?
	let id : Int?
	let v_name : String?
	let fk_facility_id : Int?
	let fk_category_id : Int?
	let i_created_at : Int?
	let i_updated_at : Int?
	let fk_care_level_id : Int?
	let fk_program_id : Int?
	let i_deleted_at : Int?
	let facility_Category : FacilityCategory?
	let facility_GroupMembers : [FacilityGroupMembers]?

	enum CodingKeys: String, CodingKey {

		case facilityCategory = "facilityCategory"
		case facilityGroupMembers = "facilityGroupMembers"
		case id = "id"
		case v_name = "v_name"
		case fk_facility_id = "fk_facility_id"
		case fk_category_id = "fk_category_id"
		case i_created_at = "i_created_at"
		case i_updated_at = "i_updated_at"
		case fk_care_level_id = "fk_care_level_id"
		case fk_program_id = "fk_program_id"
		case i_deleted_at = "i_deleted_at"
		case facility_Category = "FacilityCategory"
		case facility_GroupMembers = "FacilityGroupMembers"
	}
    
}

extension UserGroup {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        facilityCategory = try values.decodeIfPresent(FacilityCategory.self, forKey: .facilityCategory)
        facilityGroupMembers = try values.decodeIfPresent([FacilityGroupMembers].self, forKey: .facilityGroupMembers)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        v_name = try values.decodeIfPresent(String.self, forKey: .v_name)
        fk_facility_id = try values.decodeIfPresent(Int.self, forKey: .fk_facility_id)
        fk_category_id = try values.decodeIfPresent(Int.self, forKey: .fk_category_id)
        i_created_at = try values.decodeIfPresent(Int.self, forKey: .i_created_at)
        i_updated_at = try values.decodeIfPresent(Int.self, forKey: .i_updated_at)
        fk_care_level_id = try values.decodeIfPresent(Int.self, forKey: .fk_care_level_id)
        fk_program_id = try values.decodeIfPresent(Int.self, forKey: .fk_program_id)
        i_deleted_at = try values.decodeIfPresent(Int.self, forKey: .i_deleted_at)
        facility_Category = try values.decodeIfPresent(FacilityCategory.self, forKey: .facility_Category)
        facility_GroupMembers = try values.decodeIfPresent([FacilityGroupMembers].self, forKey: .facility_GroupMembers)
    }
}
