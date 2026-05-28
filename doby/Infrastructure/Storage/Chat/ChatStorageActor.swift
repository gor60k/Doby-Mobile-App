import Foundation
import GRDB

actor ChatStorageActor {
    private let dbPool: DatabasePool
    
    init(dbPool: DatabasePool) {
        self.dbPool = dbPool
    }
    
    func observeMessages(from chatID: Int64) -> AsyncValueObservation<[Message]> {
        ValueObservation
            .tracking { db in
                try Message
                    .filter(Column("chatID") == chatID)
                    .order(Column("createdAt"))
                    .fetchAll(db)
            }
            .values(in: dbPool)
    }
}
