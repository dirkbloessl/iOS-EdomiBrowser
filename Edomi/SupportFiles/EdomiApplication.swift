import UIKit
import Foundation

class EdomiApplication: UIApplication {
    
    override init() {
        super.init()
        resetIdleTimer()
    }
    
    private var timeoutInSeconds: TimeInterval {
        // 1 minute
        return 1 * 60
    }
    
    private var idleTimer: Timer?
    private var initialized = false;
    
    // reset the timer because there was user interaction
    private func resetIdleTimer() {
        if let idleTimer = idleTimer {
            idleTimer.invalidate()
        }
        
        idleTimer = Timer.scheduledTimer(timeInterval: timeoutInSeconds,
                                         target: self,
                                         selector: #selector(EdomiApplication.timeHasExceeded),
                                         userInfo: nil,
                                         repeats: false
        )
    }
    
    // if the timer reaches the limit as defined in timeoutInSeconds, post this notification
    @objc private func timeHasExceeded() {
        let state = UIApplication.shared.applicationState
        if state == .active {
            NotificationCenter.default.post(name: .appTimeout, object: nil)
        } else {
            self.resetIdleTimer()
        }
    }
    
    public func startTimerOnStartup() {
        if(!self.initialized) {
            self.resetIdleTimer()
            self.initialized = true;
        }
    }
    
    override func sendEvent(_ event: UIEvent) {
        
        super.sendEvent(event)
        
        if let touches = event.allTouches {
            for touch in touches where touch.phase == UITouch.Phase.began {
                self.resetIdleTimer()
            }
        }
    }
}

