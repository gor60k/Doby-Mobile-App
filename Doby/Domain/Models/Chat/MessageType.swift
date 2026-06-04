import Foundation

enum MessageType: String, CaseIterable, Codable {
    case audio, video, image, file, text
}
