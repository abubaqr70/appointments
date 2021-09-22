// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct StartDate : Codable {
    
    let date : String?
    let timeFormat : String?
    let dateFromat : String?
    let dateString : String?
    let timeString : String?

    enum CodingKeys: String, CodingKey {

        case date = "m"
        case timeFormat = "t"
        case dateFromat = "d"
        case dateString = "s"
        case timeString = "time"
    }

}

extension StartDate {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        timeFormat = try values.decodeIfPresent(String.self, forKey: .timeFormat)
        dateFromat = try values.decodeIfPresent(String.self, forKey: .dateFromat)
        dateString = try values.decodeIfPresent(String.self, forKey: .dateString)
        timeString = try values.decodeIfPresent(String.self, forKey: .timeString)
    }

}
