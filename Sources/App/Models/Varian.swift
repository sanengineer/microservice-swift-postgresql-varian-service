import Fluent
import Vapor
import FluentPostgresDriver

final class Varian: Model, Content {
    
    static let schema = "varians"
    
    @ID
    var id: UUID?

    @Field(key: "size")
    var size: Size
    
    @Field(key: "sugar")
    var sugar: Sugar
    
    @Field(key: "ice")
    var ice: Ice
    
    @Timestamp(key: "created_at", on: .create, format: .default)
    var created_at: Date?
    
    @Timestamp(key: "updated_at", on: .update, format: .default)
    var updated_at: Date?

    init() { }

    init(id: UUID? = nil, size: Size, sugar: Sugar, ice: Ice, created_at: Date? = nil, updated_at: Date? = nil  ) {
        self.id = id
        self.size = size
        self.sugar = sugar
        self.ice = ice
        self.created_at = created_at
        self.updated_at = updated_at
    }
}

enum Size: String, Codable {
    case small = "small"
    case regular = "regular"
    case tall = "tall"
}

enum Sugar: String, Codable {
    case less = "less"
    case normal = "normal"
    case more = "more"
}

enum Ice: String, Codable {
    case less = "less"
    case normal = "normal"
    case more = "more"
}

