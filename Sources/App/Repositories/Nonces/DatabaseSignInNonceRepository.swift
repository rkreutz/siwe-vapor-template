import Vapor
import Fluent

struct DatabaseSignInNonceRepository: SignInNonceRepository, DatabaseRepository {

    let database: Database

    func create() async throws -> SignInNonce {
        let nonce = SignInNonce(id: UUID())
        try await nonce.create(on: database)
        return nonce
    }

    func exists(id: String) async throws -> Bool {
        try await SignInNonce.find(id, on: database) != nil
    }

    func delete(id: String) async throws {
        try await SignInNonce.query(on: database)
            .filter(\.$id == id)
            .delete()
    }
}
