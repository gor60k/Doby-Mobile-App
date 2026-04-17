import Foundation
import Observation

@Observable
final class PrimaryTagsViewModel {
    let type: TagType
    let placeholder: String
    
    var input: String = ""
    var tags: [String] = []
    
    init(
        type: TagType,
        placeholder: String,
        tags: [String] = []
    ) {
        self.type = type
        self.placeholder = placeholder
        self.tags = tags
    }
    
    var isAddButtonDisabled: Bool {
        trimmedInput.isEmpty
    }
    
    func addTag() {
        let value = trimmedInput
        guard !value.isEmpty else { return }
        
        guard !tags.contains(value) else {
            input = ""
            return
        }
        
        tags.append(value)
        input = ""
    }
    
    func removeTag(_ tag: String) {
        tags.removeAll { $0 == tag }
    }
    
    private var trimmedInput: String {
        input.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
