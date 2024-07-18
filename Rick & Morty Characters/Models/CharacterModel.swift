import SwiftUI

// MARK: - CharacterJSONModel
struct CharacterJSONModel: Decodable {
    let info: Info
    let results: [CharacterModel]
}

// MARK: - Info
struct Info: Decodable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

// MARK: - CharacterModel
struct CharacterModel: Decodable {
    enum Status: String, Decodable, CaseIterable {
        case dead = "Dead"
        case alive = "Alive"
        case unknown = "unknown"
        
        func getRawValue() -> String {
            switch self {
            case .dead: "Dead"
            case .alive: "Alive"
            case .unknown: "Unknown"
            }
        }
    }
    
    enum Gender: String, Decodable, CaseIterable {
        case female = "Female"
        case male = "Male"
        case genderless = "Genderless"
        case unknown = "unknown"
        
        func getRawValue() -> String {
            switch self {
            case .female: "Female"
            case .male: "Male"
            case .genderless: "Genderless"
            case .unknown: "Unknown"
            }
        }
    }
    
    struct Location: Decodable {
        let name: String
        let url: String
    }
    
    let id: Int
    let name: String
    let imagePath: String
    let status: Status
    let gender: Gender
    let species: String
    let episode: [String]
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imagePath = "image"
        case status
        case gender
        case species
        case episode
        case location
    }
}

extension CharacterModel {
    var statusColor: Color {
        switch self.status {
        case .alive: Color.green2
        case .dead: Color.red2
        case .unknown: Color.gray2
        }
    }
    
    func getEpisodes() -> String {
        episode.compactMap { url in
            let components = url.split(separator: "/")
            
            if let lastComponent = components.last, 
                let episodeNumber = Int(lastComponent) {
                return episodeNumber
            }
            return nil
        }.sorted().map { String($0) }.joined(separator: ", ")
        
    }
    
    static let mock = CharacterModel(id: 1,
                                     name: "Toxic Rick",
                                     imagePath: "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
                                     status: .dead,
                                     gender: .male,
                                     species: "Humanoid",
                                     episode: ["https://rickandmortyapi.com/api/episode/27"], 
                                     location: CharacterModel.Location(name: "Earth", url: ""))
}

extension CharacterModel: Equatable {
    static func == (lhs: CharacterModel, rhs: CharacterModel) -> Bool {
        lhs.id == rhs.id
    }
}
