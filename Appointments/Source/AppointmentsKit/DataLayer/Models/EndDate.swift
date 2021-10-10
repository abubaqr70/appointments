// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct EndDate : Codable {
    
	let date : String?
	let timeString : String?

	enum CodingKeys: String, CodingKey {

		case date = "m"
		case timeString = "time"
	}

}

extension EndDate {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        timeString = try values.decodeIfPresent(String.self, forKey: .timeString)
    }

}

extension EndDate {
    
    init(managedObject: CDEndDate){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
        self.date = dateFormatter.string(from: managedObject.date ?? Date())
        self.timeString = managedObject.timeString
    }

}

extension EndDate {
    
    init(endDate: EndDate){
        self.date = endDate.date
        self.timeString = endDate.timeString
    }

}
