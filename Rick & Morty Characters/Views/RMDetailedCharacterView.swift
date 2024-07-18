//
//  RMDetailedCharacterView.swift
//  Rick & Morty Characters
//
//  Created by Глеб Капустин on 17.07.2024.
//

import SwiftUI

struct RMDetailedCharacterView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    let character: CharacterModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 12) {
                    
                    VStack(spacing: 12) {
                        AsyncImage(url: URL(string: character.imagePath)) { phase in
                            phase.image?
                                .resizable()
                                .frame(maxWidth: 320, maxHeight: 320)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        }
                        
                        Text(character.status.getRawValue())
                            .font(.custom("IBMPlexSans-SemiBold", size: 16))
                            .foregroundStyle(.accent)
                            .frame(maxWidth: 320, minHeight: 42)
                            .background(character.statusColor)
                            .clipShape(Capsule())
                        
                    }
                    
                    VStack(alignment: .leading) {
                        
                        Text("Species: ")
                            .font(.custom("IBMPlexSans-SemiBold", size: 14))
                        + Text(character.species)
                            .font(.custom("IBMPlexSans-Regular", size: 14))
                        
                        
                        
                        Text("Gender: ")
                            .font(.custom("IBMPlexSans-SemiBold", size: 14))
                        + Text(character.gender.getRawValue())
                            .font(.custom("IBMPlexSans-Regular", size: 14))
                        
                        
                        
                        Text("Episodes: ")
                            .font(.custom("IBMPlexSans-SemiBold", size: 14))
                        + Text(viewModel.episodes)
                            .font(.custom("IBMPlexSans-Regular", size: 14))
                        
                        
                        
                        Text("Last known location: ")
                            .font(.custom("IBMPlexSans-SemiBold", size: 14))
                        + Text(character.location.name)
                            .font(.custom("IBMPlexSans-Regular", size: 14))
                        
                    }
                    .foregroundStyle(.accent)
                    
                }
                .padding()
                .background(.black2)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                
                Spacer()
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(character.name)
                    .font(.custom("IBMPlexSans-Bold", size: 24))
                    .foregroundStyle(.accent)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color(UIColor.label))
        .task {
            await viewModel.fetchEpisodes(episodes: character.getEpisodes())
        }
    }
}

#Preview {
    RMDetailedCharacterView(viewModel: ViewModel(), character: CharacterModel.mock)
}
