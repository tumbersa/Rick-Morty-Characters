import Foundation

// MARK: - EpisodesModel
struct EpisodesModel: Decodable {
    let id: Int
    let name: String
}

typealias EpisodesJSONModel = [EpisodesModel]
