import Foundation

struct ChatMapper {
    nonisolated static func map(dto: ChatDTO) -> ChatPayload {
        ChatPayload(
            chat: ChatRecord(
                id: dto.id,
                booking: dto.booking,
                dtCreated: dto.dt_created
            ),
            participants: UserMapper.mapToRecord(dtos: dto.participants),
            messages: MessageMapper.mapToRecord(dtos: dto.messages, chatId: dto.id)
        )
    }
}
