// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Levels : Codable {
    
	let id : Int?
	let v_name : String?
	let v_number : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case v_name = "v_name"
		case v_number = "v_number"
	}

}

extension Levels {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        v_name = try values.decodeIfPresent(String.self, forKey: .v_name)
        v_number = try values.decodeIfPresent(String.self, forKey: .v_number)
    }

}
