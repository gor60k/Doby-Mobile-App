import Foundation
import GRDB

enum MigrationsManager {
    static func makeMigrator() -> DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        migrator.registerMigration("v1_create_users") { db in
            try db.create(table: UserRecord.databaseTableName) { t in
                t.column("uuid", .text)
                    .primaryKey()
                
                t.column("username", .text)
                    .notNull()
                
                t.column("firstName", .text)
                t.column("lastName", .text)
                t.column("patronymic", .text)
                
                t.column("photos", .blob)
            }
        }
        
        migrator.registerMigration("v2_create_chats") { db in
            try db.create(table: ChatRecord.databaseTableName) { t in
                t.column("id", .integer)
                    .primaryKey()
                
                t.column("booking", .integer)
                    .notNull()
                    .unique()
                    .references("bookings",
                                column: "id",
                                onDelete: .cascade
                    )
                
                t.column("dtCreated", .datetime)
                    .notNull()
                
                t.column("isPinned", .boolean)
                    .notNull()
                    .defaults(to: false)
            }
        }
        
        migrator.registerMigration("v3_create_messages", migrate: <#T##(Database) throws -> Void#>)
    }
}
