import Vapor
import Foundation

struct SignInResponse: Content {
    var userId: UUID?
    var address: String
}
