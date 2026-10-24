import GRDB

extension MigrationsManager {
    static func registerUserMigrations(in migrator: inout DatabaseMigrator) {
        migrator.registerMigration("v1_create_users") { db in
            try db.create(table: UserRecord.databaseTableName) { t in
                t.column("uuid", .text).primaryKey()
                t.column("username", .text).notNull()
                t.column("firstName", .text)
                t.column("lastName", .text)
                t.column("patronymic", .text)
                t.column("phone", .text)
                t.column("city_id", .integer)
                t.column("bio", .text)
            }
        }
    }
}
