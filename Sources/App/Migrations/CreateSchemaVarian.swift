import Fluent

struct CreateVarianSchema: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Varian.schema)
            .id()
            .field("size", .string, .required)
            .field("sugar", .string, .required)
            .field("ice", .string, .required)
            .field("item_id", .uuid, .required)
            .field("user_id", .uuid, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .unique(on: "item_id")
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Varian.schema).delete()
    }
}
