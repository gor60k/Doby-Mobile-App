import GRDB

extension MigrationsManager {
    static func registerChatMigrations(in migrator: inout DatabaseMigrator) {
        migrator.registerMigration("v2_create_chats") { db in
            try db.create(table: ChatRecord.databaseTableName) { t in
                t.column("id", .integer)
                    .primaryKey()
                
                t.column("booking", .integer)
                    .unique()
                    .references(
                        "bookings",
                        column: "id",
                        onDelete: .setNull
                    )
                
                t.column("dtCreated", .datetime)
                    .notNull()
                
                t.column("isPinned", .boolean)
                    .notNull()
                    .defaults(to: false)
            }
        }
    }
}
