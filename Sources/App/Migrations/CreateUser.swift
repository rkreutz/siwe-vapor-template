import Fluent

struct CreateUser: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(User.schema)
            .id()
            .field("address", .string, .required)
            .unique(on: "address")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(SignInNonce.schema).delete()
    }
}
