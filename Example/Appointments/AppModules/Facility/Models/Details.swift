// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Details : Codable {
    
	let staff : [Staff]?

	enum CodingKeys: String, CodingKey {

		case staff = "staff"
	}

}

extension Details {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        staff = try values.decodeIfPresent([Staff].self, forKey: .staff)
    }

}
