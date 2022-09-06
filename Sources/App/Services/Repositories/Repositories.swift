import Vapor
import Fluent

struct Repositories {

    private class Storage {
        var factories: [String: (Application) -> Repository] = [:]
    }

    private struct Key: StorageKey {
        typealias Value = Storage
    }

    let app: Application

    func use<R: Repository>(_ repository: R.Type) {
        assert(storage.factories[R.modelSchema] == nil, "A repository for \(R.modelSchema) has been configured already")
        storage.factories[R.modelSchema] = R.init
    }

    func repository<M: Model>(for model: M.Type) -> Repository {
        guard let factory = storage.factories[M.schema] else {
            fatalError("Repository for \(M.self) is not configured, use app.repositories.use()")
        }

        return factory(app)
    }

    private var storage: Storage {
        if app.storage[Key.self] == nil {
            app.storage[Key.self] = .init()
        }

        return app.storage[Key.self].unsafelyUnwrapped
    }
}

extension Application {
    var repositories: Repositories {
        .init(app: self)
    }

    func repository<M: Model>(for model: M.Type) -> Repository {
        repositories.repository(for: M.self)
    }
}

extension Request {
    var repositories: Repositories {
        .init(app: self.application)
    }

    func repository<M: Model>(for model: M.Type) -> Repository {
        repositories.repository(for: M.self)
    }
}
