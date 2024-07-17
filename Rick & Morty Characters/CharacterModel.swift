import SwiftUI

struct CharacterModel: Decodable {
    enum Status: String, Decodable {
        case dead = "Dead"
        case alive = "Alive"
        case unknown = "Unknown"
    }
    
    enum Gender: String, Decodable {
        case female = "Female"
        case male = "Male"
        case genderless = "Genderless"
        case unknown = "Unknown"
    }
    
    let name: String
    let imagePath: String
    let status: Status
    let gender: Gender
    let species: String
}

extension CharacterModel {
    var statusColor: Color {
        switch self.status {
            case .alive: Color.green
            case .dead: Color.red
            case .unknown: Color.gray
        }
    }
    
    
    static let mock = CharacterModel(name: "Toxic Rick",
                                     imagePath: "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
                                     status: .dead,
                                     gender: .male,
                                     species: "Humanoid")
}
