import Foundation
import Observation

@MainActor
@Observable
final class DisplayModeService {
    var mode: DisplayMode
    
    init(mode: DisplayMode = .owner) {
        self.mode = mode
    }
    
    var isOwner: Bool {
        mode.isOwner
    }
    
    var isVisitor: Bool {
        !isOwner
    }
}
