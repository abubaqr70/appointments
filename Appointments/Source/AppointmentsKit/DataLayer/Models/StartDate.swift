// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct StartDate : Codable {
    
    let date : String?
    let timeString : String?

    enum CodingKeys: String, CodingKey {

        case date = "m"
        case timeString = "time"
    }

}

extension StartDate {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        timeString = try values.decodeIfPresent(String.self, forKey: .timeString)
    }

}

extension StartDate {
    
    init(managedObject: CDStartDate) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
        self.date = dateFormatter.string(from: managedObject.date ?? Date())
        self.timeString = managedObject.timeString ?? nil
    }
    
}

extension StartDate {
    
    init(startDate: StartDate) {
        self.date = startDate.date ?? nil
        self.timeString = startDate.timeString ?? nil
    }
    
}
