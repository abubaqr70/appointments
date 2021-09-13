// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Roles : Codable {
    
	let fk_tenant_id : Int?
	let i_is_archived : Int?
	let i_is_profile : Int?
	let fk_category_id : String?
	let i_archived_date : String?
	let i_is_private : Int?
	let fk_archived_by : String?
	let v_name : String?
	let id : Int?
	let i_is_employee : Int?

	enum CodingKeys: String, CodingKey {

		case fk_tenant_id = "fk_tenant_id"
		case i_is_archived = "i_is_archived"
		case i_is_profile = "i_is_profile"
		case fk_category_id = "fk_category_id"
		case i_archived_date = "i_archived_date"
		case i_is_private = "i_is_private"
		case fk_archived_by = "fk_archived_by"
		case v_name = "v_name"
		case id = "id"
		case i_is_employee = "i_is_employee"
	}

}

extension Roles {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fk_tenant_id = try values.decodeIfPresent(Int.self, forKey: .fk_tenant_id)
        i_is_archived = try values.decodeIfPresent(Int.self, forKey: .i_is_archived)
        i_is_profile = try values.decodeIfPresent(Int.self, forKey: .i_is_profile)
        fk_category_id = try values.decodeIfPresent(String.self, forKey: .fk_category_id)
        i_archived_date = try values.decodeIfPresent(String.self, forKey: .i_archived_date)
        i_is_private = try values.decodeIfPresent(Int.self, forKey: .i_is_private)
        fk_archived_by = try values.decodeIfPresent(String.self, forKey: .fk_archived_by)
        v_name = try values.decodeIfPresent(String.self, forKey: .v_name)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        i_is_employee = try values.decodeIfPresent(Int.self, forKey: .i_is_employee)
    }
}
