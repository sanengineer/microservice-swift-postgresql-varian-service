import Fluent
import Vapor
import FluentPostgresDriver

func routes(_ app: Application) throws {
    
    guard let serverHostname = Environment.get("VARIAN_HOSTNAME") else {
        return print("No Env Server Hostname")
    }
    
    let port: Int = Int(Environment.get("VARIAN_PORT")!)!

    app.databases.use(.postgres(
        hostname: Environment.get("DB_HOSTNAME") ?? "localhost",
        username: Environment.get("DB_USERNAME")!,
        password: Environment.get("DB_PASSWORD")!,
        database: Environment.get("DB_NAME")!
    ), as: .psql)

    app.migrations.add(CreateVarianSchema())
    app.logger.logLevel = .debug
    app.http.server.configuration.port = port
    app.http.server.configuration.hostname = serverHostname
    
    try app.autoMigrate().wait()
    try app.register(collection: VarianController())
}
