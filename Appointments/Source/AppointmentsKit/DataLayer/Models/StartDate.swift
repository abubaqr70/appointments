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
    
    init(){
        self.date = nil
        self.timeString = nil
    }
    
    init(managedObject: CDStartDate){
        self.date = managedObject.date ?? nil
        self.timeString = managedObject.timeString ?? nil
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        timeString = try values.decodeIfPresent(String.self, forKey: .timeString)
    }

}
