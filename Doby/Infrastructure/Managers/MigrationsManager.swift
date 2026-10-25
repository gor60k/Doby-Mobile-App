import Foundation
import GRDB

enum MigrationsManager {
    static func makeMigrator() -> DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        // MARK: - Миграции пользователя
        registerUserMigrations(in: &migrator)
        registerUserPhotoMigrations(in: &migrator)
        
        // MARK: - Миграции питомца
        registerPetMigrations(in: &migrator)
        registerPetPhotoMigrations(in: &migrator)
        
        // MARK: - Миграции городов
        registerCityMigrations(in: &migrator)
        
        // MARK: - Миграции для чата
        registerChatMigrations(in: &migrator)
        registerChatParticipantMigrations(in: &migrator)
        
        // MARK: - Миграции для сообщений
        registerMessageMigrations(in: &migrator)
        
        return migrator
    }
}
