// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct StartDate : Codable {
    
	let m : String?
	let t : String?
	let d : String?
	let s : String?
	let time : String?

	enum CodingKeys: String, CodingKey {

		case m = "m"
		case t = "t"
		case d = "d"
		case s = "s"
		case time = "time"
	}

}

extension StartDate {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        m = try values.decodeIfPresent(String.self, forKey: .m)
        t = try values.decodeIfPresent(String.self, forKey: .t)
        d = try values.decodeIfPresent(String.self, forKey: .d)
        s = try values.decodeIfPresent(String.self, forKey: .s)
        time = try values.decodeIfPresent(String.self, forKey: .time)
    }

}
