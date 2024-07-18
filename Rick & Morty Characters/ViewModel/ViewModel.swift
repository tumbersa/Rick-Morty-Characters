import Foundation
import Combine

final class ViewModel: ObservableObject {
    @Published private(set) var characters: [CharacterModel] = []
    @Published private(set) var isLoading = false
    @Published private(set) var episodes: String = ""
    
    private var cancellable: AnyCancellable?
    private var page = 0
    
    @MainActor
    func fetchCharacters() async {
        isLoading = true
        page += 1
        debugPrint("page: \(page)")
        
        do {
           
            let fetchedCharacters = try await NetworkManager.shared.fetchCharacters(page: page)
            self.characters += fetchedCharacters
            
        } catch {
            
            if (error as NSError).code == NSURLErrorCancelled {
                debugPrint("Request was cancelled: \(error)")
            } else {
                debugPrint("Error fetching characters: \(error)")
            }
            page -= 1
            debugPrint(isLoading)
        }
        self.isLoading = false
    }
    
    
    @MainActor
    func fetchEpisodes(episodes: String) async {
        
        self.episodes = ""
        do {
            let fetchedEpisodes = try await NetworkManager.shared.fetchEpisodes(episodes: episodes)
            self.episodes = fetchedEpisodes.map { $0.name }.joined(separator: ", ")
        } catch {
            
            if (error as NSError).code == NSURLErrorCancelled {
                debugPrint("Request was cancelled: \(error)")
            } else {
                debugPrint("Error fetching characters: \(error)")
            }
            
        }
    }
    
    func hasLast(character: CharacterModel) -> Bool {
        characters.last == character
    }
    
    deinit {
        cancellable?.cancel()
    }
}

