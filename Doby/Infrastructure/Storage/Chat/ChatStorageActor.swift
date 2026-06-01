import Foundation
import GRDB

actor ChatStorageActor {
    private let dbPool: DatabasePool
    
    init(dbPool: DatabasePool) {
        self.dbPool = dbPool
    }
    
    func sync(
        chat: ChatRecord,
        participants: [UserRecord],
        messages: [MessageRecord]
    ) throws {
        try dbPool.write { db in
            try chat.save(db)

            for participant in participants {
                try participant.save(db)
            }

            for message in messages {
                try message.save(db)
            }
        }
    }

    func saveMessage(_ message: MessageRecord) throws {
        try dbPool.write { db in
            try message.save(db)
        }
    }
    
    func observeChats() -> AsyncValueObservation<[ChatRecord]> {
        ValueObservation
            .tracking { db in
                try ChatRecord
                    .order(Column("dtCreated").desc)
                    .fetchAll(db)
            }
            .values(in: dbPool)
    }

    func observeParticipants(from chatID: Int64) -> AsyncValueObservation<[UserRecord]> {
        ValueObservation
            .tracking { db in
                try UserRecord.fetchAll(db)
            }
            .values(in: dbPool)
    }
    
    func observeMessages(from chatID: Int64) -> AsyncValueObservation<[MessageRecord]> {
        ValueObservation
            .tracking { db in
                try MessageRecord
                    .filter(Column("chatID") == chatID)
                    .order(Column("createdAt"))
                    .fetchAll(db)
            }
            .values(in: dbPool)
    }
}
