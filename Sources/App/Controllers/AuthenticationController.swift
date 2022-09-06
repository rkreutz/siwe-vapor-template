import Vapor
import Fluent
import Web3Vapor
import web3

struct AuthenticationController: RouteCollection {

    func boot(routes: RoutesBuilder) throws {
        let auth = routes.grouped("auth")
        auth.get("nonce", use: nonce)
        let web3Verified = auth.grouped(User.web3Authenticator(delegate: self), User.guardMiddleware(throwing: Abort(.unauthorized, reason: "Invalid message/signature")))
        web3Verified.post("verify", use: verify)
    }

    func nonce(request: Request) async throws -> String {
        guard let nonce = try await request.nonces.create().id else { throw Abort(.internalServerError, reason: "Couldn't generate nonce") }
        return nonce
    }

    func verify(request: Request) async throws -> SignInResponse {
        let user = try request.auth.require(User.self)
        return SignInResponse(
            userId: user.id,
            address: user.address
        )
    }
}

extension AuthenticationController: Web3AuthenticationDelegate {
    func verify(message: SiweMessage, in request: Request) async throws -> Bool {
        guard message.domain == request.application.http.server.configuration.hostname else { return false }
        guard try await request.nonces.exists(id: message.nonce) else { return false }
        return true
    }

    func didLogin(with message: SiweMessage, in request: Request) async throws {
        try await request.nonces.delete(id: message.nonce)
    }
}
