//
//  RMDetailedCharacterView.swift
//  Rick & Morty Characters
//
//  Created by Глеб Капустин on 17.07.2024.
//

import SwiftUI

struct RMDetailedCharacterView: View {
    
    let character: CharacterModel
    
    var body: some View {
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
                        .frame(maxWidth: 320, maxHeight: 42)
                        .background(character.statusColor)
                        .clipShape(Capsule())
                    
                }
                
                VStack(alignment: .leading) {
                    Text("Species: \(character.species)")
                    Text("Gender: \(character.gender.getRawValue())")
                    Text("Episodes: \(character.getEpisodes())")
                    Text("Last known location: \(character.location.name)")
                }
                .font(.custom("IBMPlexSans-Regular", size: 14))
                .foregroundStyle(.accent)
                
            }
            .padding()
            .background(.black2)
            .clipShape(RoundedRectangle(cornerRadius: 20.0))
            
            Spacer()
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
    }
}

#Preview {
    RMDetailedCharacterView(character: CharacterModel.mock)
}
