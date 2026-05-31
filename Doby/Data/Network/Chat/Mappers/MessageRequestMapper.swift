struct MessageRequestMapper {
    nonisolated static func map(input: MessageInput) -> MessageRequest {
        return MessageRequest(
            chat: input.chat,
            text: input.text,
            media_file: input.media_file
        )
    }
}

