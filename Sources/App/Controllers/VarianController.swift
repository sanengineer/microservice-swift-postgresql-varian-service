import Fluent
import Vapor

struct VarianController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let varianRouteGroup = routes.grouped("varian")
        varianRouteGroup.get(use: getAllVarian)
        varianRouteGroup.post(use: createVarian )
        
        varianRouteGroup.group(":varian_id") { varianRoute in
            varianRoute.get(use: getOneVarian)
        }
    }

    func getAllVarian(req: Request) throws -> EventLoopFuture<[Varian]> {
        return Varian.query(on: req.db).all()
    }

    func createVarian(req: Request) throws -> EventLoopFuture<Varian> {
        let varian = try req.content.decode(Varian.self)
        return varian.save(on: req.db).map { varian }
    }

    func getOneVarian(req: Request) throws -> EventLoopFuture<Varian> {
        Varian.find(req.parameters.get("varian_id"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
}
