import GRDB

extension MigrationsManager {
    static func registerChatParticipantMigrations(in migrator: inout DatabaseMigrator) {
        migrator.registerMigration("v3_create_chat_participants") { db in
            try db.create(table: ChatParticipantRecord.databaseTableName) { t in
                t.column("chatId", .integer)
                    .notNull()
                    .references(
                        ChatRecord.databaseTableName,
                        column: "id",
                        onDelete: .cascade
                    )
                
                t.column("userUUID", .text)
                    .notNull()
                    .references(
                        UserRecord.databaseTableName,
                        column: "uuid",
                        onDelete: .cascade
                    )
                
                t.primaryKey(["chatId", "userUUID"])
            }
        }
    }
}
