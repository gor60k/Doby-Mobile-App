import GRDB

extension MigrationsManager {
    static func registerPetPhotoMigrations(in migrator: inout DatabaseMigrator) {
        migrator.registerMigration("v1_create_pet_photos") { db in
            try db.create(table: PetPhotoRecord.databaseTableName) { t in
                t.primaryKey("id", .integer)
                t.column("pet_id", .integer).notNull().indexed().references(PetRecord.databaseTableName, onDelete: .cascade)
                t.column("image_url", .text).notNull()
                t.column("order_number", .integer).notNull()
                t.column("is_main", .boolean)
            }
        }
    }
}
