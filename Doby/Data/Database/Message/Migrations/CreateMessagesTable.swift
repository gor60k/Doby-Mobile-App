import GRDB

extension MigrationsManager {
    static func registerMessageMigrations(in migrator: inout DatabaseMigrator) {
        migrator.registerMigration("v4_create_messages") { db in
            try db.create(table: MessageRecord.databaseTableName) { t in
                t.column("id", .integer)
                    .primaryKey()
                
                t.column("chatId", .integer)
                    .notNull()
                    .references(
                        ChatRecord.databaseTableName,
                        column: "id",
                        onDelete: .cascade
                    )
                
                t.column("senderUUID", .text)
                    .notNull()
                    .references(
                        UserRecord.databaseTableName,
                        column: "uuid",
                        onDelete: .cascade
                    )
                
                t.column("text", .text)
                    .notNull()
                
                t.column("originalFileName", .text)
                t.column("messageType", .integer)
                    .notNull()
            }
        }
    }
}
