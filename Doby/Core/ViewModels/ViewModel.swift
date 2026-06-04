import Foundation
import Observation

@MainActor
@Observable
class ViewModel {
    var isLoading = false
    var error: String?
    
    func perform(
        _ action: () async throws -> Void
    ) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await action()
        } catch {
            self.error = error.localizedDescription
        }
    }
}
