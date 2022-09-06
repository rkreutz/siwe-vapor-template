import Fluent

struct CreateSignInNonce: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(SignInNonce.schema)
            .field("nonce", .string, .identifier(auto: false))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(SignInNonce.schema).delete()
    }
}
