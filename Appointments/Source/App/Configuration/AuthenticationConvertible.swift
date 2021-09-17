// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

public protocol AuthenticationConvertible {
    var accessTokenKey: String { get }
    var accessToken: String? { get }
}

extension AuthenticationConvertible {
    
    var authenticationHeader: [String: String?] {
        return [self.accessTokenKey: self.accessToken]
    }
}
