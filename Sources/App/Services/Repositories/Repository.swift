import Vapor

protocol Repository {
    static var modelSchema: String { get }
    init(app: Application)
}
