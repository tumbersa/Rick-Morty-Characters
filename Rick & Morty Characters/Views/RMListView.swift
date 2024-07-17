import SwiftUI

struct RMListView: View {
    
    @State private var page = 1
    @State private var characters: [CharacterModel] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(characters, id: \.name) { character in
                    VStack(spacing: 0) {
                        NavigationLink {
                            RMDetailedCharacterView(character: character)
                                .toolbarRole(.editor)
                        } label: {
                            RMListCellView(character: character)
                        }
                        
                        Spacer().frame(height: 4)
                    }
                    .contentShape(Rectangle())
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.black)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .padding([.top, .bottom])
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Rick & Morty Characters")
                        .font(.custom("IBMPlexSans-Bold", size: 24))
                        .foregroundStyle(.accent)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Color(UIColor.label))
            .onAppear {
                Task {
                    do {
                        self.characters = try await NetworkManager.shared.fetchCharacters(page: page)
                        print(characters)
                    } catch {
                        debugPrint(error)
                    }
                }
            }
        }
    }
}

#Preview {
    RMListView()
}
