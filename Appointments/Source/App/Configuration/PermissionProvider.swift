// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

public protocol PermissionProvider {
    var authorizedToManageAppointments: Bool { get }
    var authorizedToViewTitleAppointments: Bool { get }
    var authorizedToViewTitleAndDescriptionAppointments: Bool { get }
}
