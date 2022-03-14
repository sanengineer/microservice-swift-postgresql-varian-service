import Fluent
import Vapor

struct VarianController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let superUserMiddleware = SuperUserAuthMiddleware()
        let midUserMiddleware = MidUserAuthMiddleware()
        let userMiddleware = UserAuthMiddleware()
        
        let varianRouteGroup = routes.grouped("varian")

        let _ = varianRouteGroup.grouped(superUserMiddleware)
        let _ = varianRouteGroup.grouped(midUserMiddleware)
        let varianAuthUser = varianRouteGroup.grouped(userMiddleware)

        // varianAuthSuperUser.delete(":varian_id", use: delete)
        
        varianAuthUser.get(use: getAllVarian)
        varianAuthUser.post(use: createVarian )
        
        varianAuthUser.group(":varian_id") { varianRoute in
            varianRoute.get(use: getOneVarian)
        }

        varianAuthUser.delete(use: deleteByItemId)
    }

    func getAllVarian(req: Request) throws -> EventLoopFuture<[Varian]> {
         Varian.query(on: req.db).all()
    }

    func createVarian(req: Request) throws -> EventLoopFuture<Varian> {
        let varian = try req.content.decode(Varian.self)
        return varian.save(on: req.db).map { varian }
    }

    func getOneVarian(req: Request) throws -> EventLoopFuture<Varian> {
        Varian.find(req.parameters.get("varian_id"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }

    func getOneVarianByItemId(_ req: Request) throws -> EventLoopFuture<Varian> {
        Varian.find(req.parameters.get("item_id"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }

    func deleteByItemId(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let payload = try req.content.decode(DeleteByItemId.self)
        //debug
        print("payload", payload.user_id)
        
       return Varian.query(on: req.db)
            .filter(\.$user_id == payload.user_id)
            .filter(\.$item_id == payload.item_id)
            .delete()
            .transform(to: .noContent)
    }
}
