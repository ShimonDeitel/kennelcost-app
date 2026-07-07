import Foundation

struct Stay: Identifiable, Codable, Equatable {
    let id: UUID
    var provider: String
    var cost: Double
    var startDate: Date
    var endDate: Date
    var createdAt: Date

    init(id: UUID = UUID(), provider: String = "", cost: Double = 0, startDate: Date = Date(), endDate: Date = Date(), createdAt: Date = Date()) {
        self.id = id
        self.provider = provider
        self.cost = cost
        self.startDate = startDate
        self.endDate = endDate
        self.createdAt = createdAt
    }
}
