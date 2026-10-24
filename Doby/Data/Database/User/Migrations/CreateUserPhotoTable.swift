import GRDB

extension MigrationsManager {
    static func registerUserPhotoMigrations(in migrator: inout DatabaseMigrator) {
        migrator.registerMigration("v1_create_user_photos") { db in
            try db.create(table: UserPhotoRecord.databaseTableName) { t in
                t.primaryKey("id", .integer)
                t.column("user_id", .integer).notNull().indexed().references(UserRecord.databaseTableName, onDelete: .cascade)
                t.column("image_url", .text).notNull()
                t.column("order_number", .integer).notNull()
                t.column("is_main", .boolean)
            }
        }
    }
}
