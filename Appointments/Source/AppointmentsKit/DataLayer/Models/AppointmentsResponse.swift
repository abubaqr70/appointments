// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct AppointmentsResponse : Codable {
    
    let success : Bool?
    let failures : [Failures]?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case failures = "failures"
        case message = "message"
    }
    
}

extension AppointmentsResponse {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        failures = try values.decodeIfPresent([Failures].self, forKey: .failures)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
    
}
