// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Tags : Codable {
    
	let v_name : String?
	let i_archived : String?
	let fk_facility_id : Int?
	let v_action_structure : String?
	let levels : [Levels]?
	let v_type : Int?
	let i_status : Int?
	let i_show_in_family_app : Int?
	let i_show_in_todos_app : Int?
	let parentFacilityId : Int?
	let id : Int?
	let v_action_clause_todos : String?
	let i_show_in_notes_app : Int?
	let v_action_clause : String?

	enum CodingKeys: String, CodingKey {

		case v_name = "v_name"
		case i_archived = "i_archived"
		case fk_facility_id = "fk_facility_id"
		case v_action_structure = "v_action_structure"
		case levels = "levels"
		case v_type = "v_type"
		case i_status = "i_status"
		case i_show_in_family_app = "i_show_in_family_app"
		case i_show_in_todos_app = "i_show_in_todos_app"
		case parentFacilityId = "parentFacilityId"
		case id = "id"
		case v_action_clause_todos = "v_action_clause_todos"
		case i_show_in_notes_app = "i_show_in_notes_app"
		case v_action_clause = "v_action_clause"
	}

}

extension Tags {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        v_name = try values.decodeIfPresent(String.self, forKey: .v_name)
        i_archived = try values.decodeIfPresent(String.self, forKey: .i_archived)
        fk_facility_id = try values.decodeIfPresent(Int.self, forKey: .fk_facility_id)
        v_action_structure = try values.decodeIfPresent(String.self, forKey: .v_action_structure)
        levels = try values.decodeIfPresent([Levels].self, forKey: .levels)
        v_type = try values.decodeIfPresent(Int.self, forKey: .v_type)
        i_status = try values.decodeIfPresent(Int.self, forKey: .i_status)
        i_show_in_family_app = try values.decodeIfPresent(Int.self, forKey: .i_show_in_family_app)
        i_show_in_todos_app = try values.decodeIfPresent(Int.self, forKey: .i_show_in_todos_app)
        parentFacilityId = try values.decodeIfPresent(Int.self, forKey: .parentFacilityId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        v_action_clause_todos = try values.decodeIfPresent(String.self, forKey: .v_action_clause_todos)
        i_show_in_notes_app = try values.decodeIfPresent(Int.self, forKey: .i_show_in_notes_app)
        v_action_clause = try values.decodeIfPresent(String.self, forKey: .v_action_clause)
    }

}
