import Fluent
import Vapor
import FluentPostgresDriver

final class Varian: Model, Content {
    static let schema = "varians"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "size")
    var size: Size
    
    @Field(key: "sugar")
    var sugar: Sugar
    
    @Field(key: "ice")
    var ice: Ice

    @Field(key: "item_id")
    var item_id: UUID

    @Field(key: "user_id")
    var user_id: UUID
    
    @Timestamp(key: "created_at", on: .create, format: .default)
    var created_at: Date?
    
    @Timestamp(key: "updated_at", on: .update, format: .default)
    var updated_at: Date?

    init() { }

    init(id: UUID? = nil, size: Size, sugar: Sugar, ice: Ice, item_id: UUID , user_id: UUID ,created_at: Date? = nil, updated_at: Date? = nil  ) {
        self.id = id
        self.size = size
        self.sugar = sugar
        self.ice = ice
        self.item_id = item_id
        self.user_id = user_id
        self.created_at = created_at
        self.updated_at = updated_at
    }
}

final class DeleteByItemId: Content, Codable {
    var item_id: UUID
    var user_id: UUID
    
    init(item_id: UUID, user_id: UUID) {
        self.item_id = item_id
        self.user_id = user_id
    }
} 

final class ResponDelete: Content, Codable {
    var status: Bool
    var message: String

    init(status: Bool, message: String) {
        self.status = status
        self.message = message
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

