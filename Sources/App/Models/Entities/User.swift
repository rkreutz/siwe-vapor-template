import Vapor
import Fluent
import Web3Vapor

final class User: Web3ModelAuthenticatable {
    static let web3AddressKey = \User.$address
    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "address")
    var address: String

    init() {}

    init(
        id: UUID? = nil,
        address: String
    ) {
        self.id = id
        self.address = address
    }
}
