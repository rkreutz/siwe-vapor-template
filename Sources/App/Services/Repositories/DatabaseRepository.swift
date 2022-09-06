import Vapor
import Fluent

protocol DatabaseRepository: Repository {
    init(database: Database)
}

extension DatabaseRepository {
    init(app: Application) {
        self.init(database: app.db)
    }
}
