import Fluent
import Vapor

final class Varian: Model, Content {
    
    static let schema = "varians"
    
    @ID
    var id: UUID?

    @Field(key: "size")
    var size: Size
    
    @Field(key: "sugar")
    var sugar: Sugar
    
    @Field(key: "Ice")
    var ice: Ice

    init() { }

    init(id: UUID? = nil, size: Size, sugar: Sugar, ice: Ice  ) {
        self.id = id
        self.size = size
        self.sugar = sugar
        self.ice = ice
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

