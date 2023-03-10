// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct AppointmentUser : Codable {
    
    let fullName : String?
    let profileImageRoute : String?
    let gender : String?
    let id : Int?
    let firstName : String?
    let lastName : String?
    let roomNo : String?

    enum CodingKeys: String, CodingKey {

        case fullName = "fullname"
        case profileImageRoute = "profileImageRoute"
        case gender = "gender"
        case id = "id"
        case firstName = "v_first_name"
        case lastName = "v_last_name"
        case roomNo = "v_room_no"
    }

}

extension AppointmentUser {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        profileImageRoute = try values.decodeIfPresent(String.self, forKey: .profileImageRoute)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        roomNo = try values.decodeIfPresent(String.self, forKey: .roomNo)
    }

}

extension AppointmentUser {
    
    init(managedObject: CDAppointmentUser){
        self.fullName = managedObject.fullName
        self.profileImageRoute = managedObject.profileImageRoute
        self.gender = managedObject.gender
        self.id = Int(managedObject.id)
        self.firstName = managedObject.firstName
        self.lastName = managedObject.lastName
        self.roomNo = managedObject.roomNo
    }
    
}

extension AppointmentUser {
    
    init(appointmentUser: AppointmentUser){
        self.fullName = appointmentUser.fullName
        self.profileImageRoute = appointmentUser.profileImageRoute
        self.gender = appointmentUser.gender
        self.id = appointmentUser.id
        self.firstName = appointmentUser.firstName
        self.lastName = appointmentUser.lastName
        self.roomNo = appointmentUser.roomNo
    }
    
}
