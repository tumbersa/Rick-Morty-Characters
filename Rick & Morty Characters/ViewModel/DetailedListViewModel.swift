import Foundation
import Combine

final class DetailedListViewModel: ObservableObject {
   
    @Published private(set) var episodes: String = ""
    @Published var showNoInternetAlert: Bool = false
  
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
            
            showNoInternetAlert = true
        }
    }
}

