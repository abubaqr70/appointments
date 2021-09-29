// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import CoreData


extension CDAppointmentUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAppointmentUser> {
        return NSFetchRequest<CDAppointmentUser>(entityName: "CDAppointmentUser")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var fullName: String?
    @NSManaged public var gender: String?
    @NSManaged public var id: Int64
    @NSManaged public var isSynced: Bool
    @NSManaged public var lastName: String?
    @NSManaged public var profileImageRoute: String?
    @NSManaged public var roomNo: String?

}
