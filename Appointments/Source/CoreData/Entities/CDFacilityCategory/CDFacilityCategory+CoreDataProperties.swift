// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import CoreData


extension CDFacilityCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFacilityCategory> {
        return NSFetchRequest<CDFacilityCategory>(entityName: "CDFacilityCategory")
    }

    @NSManaged public var facilityId: Int64
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var ofUserGroup: CDUserGroup?

}
