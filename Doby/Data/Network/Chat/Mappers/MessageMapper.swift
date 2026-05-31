import Foundation

struct MessageMapper {
    nonisolated static func map(dto: MessageDTO) -> Message {
        return Message(
            id: dto.id,
            senderUUID: dto.sender_uuid,
            text: dto.text,
            originalFileName: dto.original_filename,
            messageType: mapMessageType(dto: dto.message_type),
            isRead: dto.is_read,
            dtCreated: dto.dt_created,
            mediaURL: dto.media_url
        )
    }
    
    nonisolated static func map(dtos: [MessageDTO]) -> [Message] {
        dtos.map(map(dto:))
    }
    
    nonisolated static func mapToRecord(dto: MessageDTO) -> MessageRecord {
        MessageRecord(
            id: dto.id,
            senderUUID: dto.sender_uuid,
            text: dto.text,
            originalFileName: dto.original_filename,
            messageType: mapMessageType(dto: dto.message_type),
            isRead: dto.is_read,
            dtCreated: dto.dt_created,
            mediaURL: dto.media_url
        )
    }
    
    nonisolated static func mapToRecord(dtos: [MessageDTO]) -> [MessageRecord] {
        dtos.map(mapToRecord(dto:))
    }
    
    nonisolated static func mapMessageType(dto: MessageTypeDTO) -> MessageType {
        switch dto {
        case .audio: return .audio
        case .file: return .file
        case .image: return .image
        case .text: return .text
        case .video: return .video
        }
    }
}
