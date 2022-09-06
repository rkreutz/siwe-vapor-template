import Vapor
import Web3Vapor

func services(_ app: Application) throws {
    app.repositories.use(DatabaseSignInNonceRepository.self)

    app.ethereumClients.use("https://ropsten.infura.io/v3/b2f4b3f635d8425c96854c3d28ba6bb0", for: .ropsten)
}
