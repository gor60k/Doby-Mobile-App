import Foundation
import os
import Observation

@Observable
final class LogService {
    static let shared = LogService()
    
    func logAsync(_ name: String, logger: Logger, operation: () async throws -> Void) async {
        logger.debug("\(name) START")
        
        do {
            try await operation()
            logger.info("\(name) SUCCESS")
        } catch {
            logger.error("\(name) ERROR: \(error.localizedDescription)")
        }
        
        logger.debug("\(name) END")
    }
}
