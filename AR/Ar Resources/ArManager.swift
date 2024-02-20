import SwiftUI
import Combine
class ARManager {
    static let shared = ARManager()
    
    private init() {
        
    }
    
    var actionStream = PassthroughSubject<ArAction, Never>()
    
}


