import GRDB

extension MigrationsManager {
    static func registerPetMigrations(in migrator: inout DatabaseMigrator) {
        migrator.registerMigration("v1_create_pets") { db in
            try db.create(table: PetRecord.databaseTableName) { t in
                t.primaryKey("id", .integer)
                t.column("owner_uuid", .text).notNull().indexed().references("users", onDelete: .cascade)
                t.column("pet_type", .text).notNull()
                t.column("name", .text).notNull()
                t.column("age", .integer).notNull()
                t.column("gender", .text).notNull()
                t.column("height", .integer).notNull()
                t.column("weight", .integer).notNull()
                t.column("breed_name", .text).notNull().defaults(to: "")
                t.column("diet_type", .text).notNull().defaults(to: "")
                t.column("diet_patterns", .text).notNull().defaults(to: "")
                t.column("diet_additional_info", .text).notNull().defaults(to: "")
                t.column("warning_tags", .jsonText).notNull().defaults(to: "[]")
                t.column("specific_tags", .jsonText).notNull().defaults(to: "[]")
                t.column("additional_info", .text).defaults(to: "")
            }
        }
    }
}
