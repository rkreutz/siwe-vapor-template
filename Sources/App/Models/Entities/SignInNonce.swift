import Vapor
import Fluent
import Foundation

final class SignInNonce: Model {
    static let schema = "nonces"

    @ID(custom: "nonce", generatedBy: .user)
    var id: String?

    init() {}

    init(id: UUID) {
        self.id = id.uuidString.replacingOccurrences(of: "-", with: "")
    }
}
