import Foundation
import GRDB

final class DatabaseManager {
    let dbPool: DatabasePool
    
    init() throws {
        do {
            let url = try FileManager.default
                .urls(for: .applicationSupportDirectory, in: .userDomainMask)
                .first!
                .appendingPathComponent("db.sqlite")
            
            try FileManager.default.createDirectory(
                at: url.deletingLastPathComponent(),
                withIntermediateDirectories: true
            )
            
            dbPool = try DatabasePool(path: url.path)
            
            try migrator.migrate(dbPool)
        } catch {
            fatalError("Ошибка инициализации ДБ: \(error)")
        }
    }
}

extension DatabaseManager {
    
    var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
            
        migrator.registerMigration("v1") { db in
            
            try db.create(table: "chats") { t in
                t.column("id", .integer).primaryKey()
                t.column("booking", .integer).notNull()
                t.column("dtCreated", .datetime).notNull()
                t.column("isPinned", .boolean)
                    .notNull()
                    .defaults(to: false)
            }
            
            try db.create(table: "messages") { t in
                t.column("id", .integer).primaryKey()
                
                t.column("chatID", .integer)
                    .notNull()
                    .indexed()
                    .references("chats", onDelete: .cascade)
                
                t.column("senderUUID", .text).notNull()
                t.column("text", .text).notNull()
                
                t.column("originalFileName", .text).notNull()
                t.column("messageType", .text).notNull()
                
                t.column("isRead", .boolean).notNull()
                
                t.column("createdAt", .datetime).notNull()
                
                t.column("mediaURL", .text).notNull()
                
                t.column("isPinned", .boolean)
                    .notNull()
                    .defaults(to: false)
            }
        }
        
        return migrator
    }
}
