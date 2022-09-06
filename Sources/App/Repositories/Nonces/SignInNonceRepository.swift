import Vapor

protocol SignInNonceRepository: Repository {
    func create() async throws -> SignInNonce
    func exists(id: String) async throws -> Bool
    func delete(id: String) async throws
}

extension SignInNonceRepository {
    static var modelSchema: String { SignInNonce.schema }
}

extension Repositories {
    var nonces: SignInNonceRepository {
        guard let repository = self.repository(for: SignInNonce.self) as? SignInNonceRepository else {
            fatalError("SignInNonceRepository not configured, use: app.repositories.use()")
        }
        return repository
    }
}

extension Request {
    var nonces: SignInNonceRepository { repositories.nonces }
}
