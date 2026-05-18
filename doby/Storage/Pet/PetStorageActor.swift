import SwiftUI

actor PetStorageActor {
    
    private let fileURL: URL
    
    init(filename: String = "pets.json") {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileURL = url.appendingPathComponent(filename)
    }
    
    func load() -> [Pet] {
        guard
            let data = try? Data(contentsOf: fileURL),
            let pets = try? JSONDecoder().decode([Pet].self, from: data)
        else { return [] }
        return pets
    }
    
    func save(_ pets: [Pet]) {
        guard let data = try? JSONEncoder().encode(pets) else { return }
        try? data.write(to: fileURL, options: [.atomic])
    }
}
