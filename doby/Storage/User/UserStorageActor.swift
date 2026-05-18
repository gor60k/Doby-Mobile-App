import SwiftUI

actor UserStorageActor {
    private let fileURL: URL
    
    init(filename: String = "user.json") {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileURL = url.appendingPathComponent(filename)
    }
    
    func load() -> User? {
        guard
            let data = try? Data(contentsOf: fileURL),
            let user = try? JSONDecoder().decode(User.self, from: data)
        else { return nil }
        return user
    }
    
    func save(_ user: User?) {
        guard let data = try? JSONEncoder().encode(user) else { return }
        try? data.write(to: fileURL, options: [.atomic])
    }
    
}
