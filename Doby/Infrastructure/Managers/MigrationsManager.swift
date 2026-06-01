import Foundation
import GRDB

enum MigrationsManager {
    static func makeMigrator() -> DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        registerUserMigrations(in: &migrator)
        registerChatMigrations(in: &migrator)
        registerChatParticipantMigrations(in: &migrator)
        registerMessageMigrations(in: &migrator)
        
        return migrator
    }
}
