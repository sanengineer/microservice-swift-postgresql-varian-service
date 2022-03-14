import Fluent
import Vapor
import FluentPostgresDriver

func routes(_ app: Application) throws {
    try app.register(collection: VarianController())
}
