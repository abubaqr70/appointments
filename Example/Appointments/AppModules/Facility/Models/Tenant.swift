// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Tenant : Codable {

    let id : Int?
    
	enum CodingKeys: String, CodingKey {
        case id = "id"
	}

}

extension Tenant {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }

}
