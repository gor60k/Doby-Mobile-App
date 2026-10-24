import GRDB

extension MigrationsManager {
    static func registerCityMigrations(in migrator: inout DatabaseMigrator) {
        migrator.registerMigration("v1_create_cities") { db in
            try db.create(table: CityRecord.databaseTableName) { t in
                t.primaryKey("id", .integer)
                t.column("name", .text)
                t.column("translit", .text)
            }
        }
    }
}
