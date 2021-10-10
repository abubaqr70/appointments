// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import Network
import AVFoundation
import SystemConfiguration

enum ReachabilityType {
    
    case connected
    case disconnected
}

enum ReachabilityConnectionType {
    
    case wifi
    case ethernet
    case cellular
    case unknown
    
}

class ReachabilityService {
    
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    var reachabilityType :ReachabilityType
    var connType: ReachabilityConnectionType
    
    init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
        self.reachabilityType = .connected
        self.connType = .wifi
    }
    
    func currentReachabilityType() -> ReachabilityType{
        self.reachabilityType = self.checkReachability(self.monitor.currentPath)
        self.connType = self.checkConnectionTypeForPath( self.monitor.currentPath)
        return self.checkReachability(self.monitor.currentPath)
    }
    
    func stopMonitoring() {
        self.monitor.cancel()
    }
    
    func checkConnectionTypeForPath(_ path: NWPath) -> ReachabilityConnectionType {
        if path.usesInterfaceType(.wifi) {
            return .wifi
        } else if path.usesInterfaceType(.wiredEthernet) {
            return .ethernet
        } else if path.usesInterfaceType(.cellular) {
            return .cellular
        }
        
        return .unknown
    }
    
    func checkReachability(_ path: NWPath) -> ReachabilityType {
        
        if path.status == .satisfied {
            return .connected
        } else if path.status == .unsatisfied {
            return .disconnected
        } else if path.isExpensive{
            return .connected
        }
        
        return .disconnected
    }
}


