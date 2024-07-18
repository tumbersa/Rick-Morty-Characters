import SwiftUI

@main
struct RMCharactersApp: App {
    var body: some Scene {
        WindowGroup {
            RMListView(viewModel: ListViewModel())
        }
    }
}
