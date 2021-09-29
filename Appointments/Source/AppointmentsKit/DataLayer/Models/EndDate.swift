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
    
    init(){
        self.date = nil
        self.timeString = nil
    }
    
    init(managedObject: CDEndDate){
        self.date = managedObject.date
        self.timeString = managedObject.timeString
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        timeString = try values.decodeIfPresent(String.self, forKey: .timeString)
    }

}
