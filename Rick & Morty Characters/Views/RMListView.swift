import SwiftUI

struct RMListView: View {
    
    @StateObject var viewModel: ViewModel
    @State private var page = 1
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    searchBar
                    
                    Button(action: {
                        
                    }, label: {
                        Image(.filterIcon)
                    })
                }
                .padding([.leading, .trailing])
                
                
                if viewModel.filteredCharacters.isEmpty {
                    RMNoMatchesView()
                        //.listRowBackground(Color.black)
                    
                    Spacer()
                } else {
                    List {
                        
                        ForEach(viewModel.filteredCharacters, id: \.id) { character in
                            VStack(spacing: 0) {
                                NavigationLink {
                                    RMDetailedCharacterView(viewModel: viewModel,character: character)
                                        .toolbarRole(.editor)
                                } label: {
                                    RMListCellView(character: character)
                                }
                                .task {
                                    if viewModel.hasLast(character: character) {
                                        await viewModel.fetchCharacters()
                                    }
                                    
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
                    
                    
                    if isLoading {
                        ProgressView()
                            .controlSize(.large)
                            .frame(width: 40, height: 40)
                            .tint(.gray2)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Rick & Morty Characters")
                        .font(.custom("IBMPlexSans-Bold", size: 24))
                        .foregroundStyle(.accent)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(UIColor.label))
            .task {
                await viewModel.fetchCharacters()
            }
            .onChange(of: viewModel.isLoading) { _, newValue in
                isLoading = newValue
            }
            
        }
        .ignoresSafeArea(.keyboard)
    }
    
    var searchBar: some View {
        HStack {
            Image(.searchIcon)
                
            TextField("", text: $viewModel.searchText, prompt: Text("Search").foregroundStyle(.white))
                .font(.custom("IBMPlexSans-Regular", size: 14))
                .foregroundStyle(.white)
        }
        .padding(12)
        .background(Color.black)
        .cornerRadius(50)
    }
}

#Preview {
    RMListView(viewModel: ViewModel())
}
