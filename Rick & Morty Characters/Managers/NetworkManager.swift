import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let decoder = JSONDecoder()
    private let baseUrl = "https://rickandmortyapi.com/api"
    
    private init() {}
    
    func fetchCharacters(page: Int) async throws -> [CharacterModel] {
        let endPoint = baseUrl + "/character/" + "?page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            throw RMError.invalidPage
        }
        
        let (data, responce) = try await URLSession.shared.data(from: url)
        
        guard let responce = responce as? HTTPURLResponse,
              200..<300 ~= responce.statusCode  else {
            debugPrint((responce as? HTTPURLResponse)?.statusCode as Any)
            throw RMError.invalidResponce
        }
        
        do {
            let charactersJson = try decoder.decode(CharacterJSONModel.self, from: data)
            return charactersJson.results
        } catch(let error) {
            throw error
        }
    }
    
    func fetchEpisodes(episodes: String) async throws -> [EpisodesModel] {
        let endPoint = baseUrl + "/episode/" + episodes
        
        
        guard let url = URL(string: endPoint) else {
            throw RMError.invalidPage
        }
        
        let (data, responce) = try await URLSession.shared.data(from: url)
        
        guard let responce = responce as? HTTPURLResponse,
              200..<300 ~= responce.statusCode  else {
            debugPrint((responce as? HTTPURLResponse)?.statusCode as Any)
            throw RMError.invalidResponce
        }
        
        do {
            if episodes.contains(",")  {
                return try decoder.decode(EpisodesJSONModel.self, from: data)
            } else {
                return [try decoder.decode(EpisodesModel.self, from: data)]
            }
            
            
        } catch(let error) {
            throw error
        }
    }
}
