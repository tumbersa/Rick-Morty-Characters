import SwiftUI

struct RMListView: View {
    
    @StateObject var listViewModel: ListViewModel
    @StateObject var detailedViewModel: DetailedListViewModel
    
    @State private var isLoading = false
    @State private var showFiltersSheet = false
    
    @State private var selectedStatus: CharacterModel.Status?
    @State private var selectedGender: CharacterModel.Gender?
    
    private var isFiltered: Bool {
        selectedGender != nil || selectedStatus != nil
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    searchBar
                    
                    Button(action: {
                        showFiltersSheet.toggle()
                    }, label: {
                        Image(.filterIcon)
                            .renderingMode(.template)
                            .foregroundStyle(isFiltered ? .rick : .accent)
                    })
                }
                .padding([.leading, .trailing])
                
                if isFiltered {
                    HStack() {
                        if let selectedStatus {
                            Text(selectedStatus.getRawValue())
                                .font(.custom("IBMPlexSans-Regular", size: 8.43))
                                .foregroundStyle(.black)
                                .padding(EdgeInsets(top: 6.5, leading: 16, bottom: 6.5, trailing: 16))
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        
                        if let selectedGender {
                            Text(selectedGender.getRawValue())
                                .font(.custom("IBMPlexSans-Regular", size: 8.43))
                                .foregroundStyle(.black)
                                .padding(EdgeInsets(top: 6.5, leading: 16, bottom: 6.5, trailing: 16))
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        
                        Button(action: {
                            selectedGender = nil
                            selectedStatus = nil
                            Task {
                                await listViewModel.fetchFilteredCharacters(selectedStatus: selectedStatus, selectedGender: selectedGender, isRefreshPage: true)
                            }
                        }, label: {
                            Text("Reset all filters")
                                .font(.custom("IBMPlexSans-Regular", size: 8.43))
                                .foregroundStyle(.white)
                                .padding(EdgeInsets(top: 6.5, leading: 16, bottom: 6.5, trailing: 16))
                                .background(.rick)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        })

                        Spacer()
                    }
                    .padding([.leading, .trailing])
                    .padding(.top, 8)
                    
                }
                
                
                if listViewModel.filteredCharacters.isEmpty && !isLoading {
                    RMNoMatchesView()
                    
                    Spacer()
                } else {
                    List {
                        
                        ForEach(listViewModel.filteredCharacters, id: \.id) { character in
                            VStack(spacing: 0) {
                                NavigationLink {
                                    RMDetailedCharacterView(viewModel: DetailedListViewModel(),character: character)
                                        .toolbarRole(.editor)
                                } label: {
                                    RMListCellView(character: character)
                                }
                                .task {
                                    if listViewModel.hasLast(character: character) {
                                        await isFiltered ? listViewModel.fetchFilteredCharacters(
                                            selectedStatus: selectedStatus,
                                            selectedGender: selectedGender
                                        ) : listViewModel.fetchCharacters()
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
                await listViewModel.fetchCharacters()
            }
            .onChange(of: listViewModel.isLoading) { _, newValue in
                isLoading = newValue
            }
            
        }
        .ignoresSafeArea(.keyboard)
        .sheet(isPresented: $showFiltersSheet, onDismiss: {
            Task {
                await listViewModel.fetchFilteredCharacters(selectedStatus: selectedStatus, selectedGender: selectedGender, isRefreshPage: true)
            }
        }, content: {
            RMMenuFiltersView(showSheet: $showFiltersSheet,
                              selectedStatus: $selectedStatus,
                              selectedGender: $selectedGender)
                .presentationDetents([.fraction(0.4)])
        })
        .sheet(isPresented: $listViewModel.showNoInternetAlert, content: {
            RMNoInternetView()
        })
    }
    
    var searchBar: some View {
        HStack {
            Image(.searchIcon)
                
            TextField("", text: $listViewModel.searchText, prompt: Text("Search").foregroundStyle(.white))
                .font(.custom("IBMPlexSans-Regular", size: 14))
                .foregroundStyle(.white)
        }
        .padding(12)
        .background(Color.black)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.black3, lineWidth: 2)
        )
        
    }
}

#Preview {
    RMListView(listViewModel: ListViewModel(), detailedViewModel: DetailedListViewModel())
}
