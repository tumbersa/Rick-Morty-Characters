import Foundation
import Combine

final class ListViewModel: ObservableObject {
    @Published private(set) var characters: [CharacterModel] = []
    @Published private(set) var isLoading = false
    @Published var searchText = ""
    
    var filteredCharacters: [CharacterModel] {
        guard !searchText.isEmpty else { return characters }
        return characters.filter { character in
            character.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    private var page = 0
    private var filteredPage = 0
    
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
    func fetchFilteredCharacters(selectedStatus: CharacterModel.Status?, selectedGender: CharacterModel.Gender?, isRefreshPage: Bool = false) async {
        
        if isRefreshPage {
            characters = []
            filteredPage = 0
        }
        
        filteredPage += 1
        
        
        do {
           
            let fetchedCharacters = try await NetworkManager.shared.fetchFilteredCharacters(page: filteredPage, status: selectedStatus, gender: selectedGender)
            self.characters += fetchedCharacters
            
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
    
}

