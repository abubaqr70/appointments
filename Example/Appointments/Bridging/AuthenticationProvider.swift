// Copyright © 2021 Caremerge. All rights reserved.


import Foundation
import Appointments

public class AuthenticationProvider: AuthenticationConvertible {
    
    public var accessTokenKey: String {
        return "x-care-merge-api-token"
    }
    
    public var accessToken: String? {
        return "" //TODO: Return Key here
    }
}
