import Foundation

struct ChatMapper {
    nonisolated static func mapToPayload(dto: ChatDTO) -> ChatPayload {
        ChatPayload(
            chat: ChatRecord(
                id: dto.id,
                booking: dto.booking,
                dtCreated: dto.dt_created
            ),
            participants: UserMapper.mapToRecord(from: dto.participants),
            messages: MessageMapper.mapToRecord(dtos: dto.messages, chatId: dto.id)
        )
    }
    
    nonisolated static func mapToRequest(from input: CreateChatInput) -> CreateChatRequest {
        CreateChatRequest(
            participants: input.participants,
            bookig_id: input.bookingId
        )
    }
}
