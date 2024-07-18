import SwiftUI

@main
struct RMCharactersApp: App {
    var body: some Scene {
        WindowGroup {
            RMListView(listViewModel: ListViewModel(), detailedViewModel: DetailedListViewModel())
        }
    }
}
