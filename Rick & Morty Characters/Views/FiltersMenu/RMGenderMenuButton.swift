//
//  RMGenderMenuButton.swift
//  Rick & Morty Characters
//
//  Created by Глеб Капустин on 18.07.2024.
//

import SwiftUI

struct RMGenderMenuButton: View {
    @Binding var selectedGender: CharacterModel.Gender?
    var currentGender: CharacterModel.Gender
    
    private var isSelected: Bool {
        selectedGender == currentGender
    }
    
    var body: some View {
        Button(action: {
            selectedGender = currentGender
        }, label: {
            HStack{
                Text(currentGender.getRawValue())
                    .font(.custom("IBMPlexSans-Regular", size: 12))
                    .foregroundStyle(isSelected ? .black : .accent)
                
                if isSelected {
                    Image(.checkmarkIcon)
                }
            }
            
        })
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .background(isSelected ? .white : .black)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(isSelected ? .white : .black3, lineWidth: 2)
        )
    }
}

#Preview {
    RMGenderMenuButton(selectedGender: .constant(nil), currentGender: .female)
}
