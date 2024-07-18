//
//  RMMenuFiltersView.swift
//  Rick & Morty Characters
//
//  Created by Глеб Капустин on 18.07.2024.
//

import SwiftUI

struct RMMenuFiltersView: View {
    
    @Binding var showSheet: Bool
    
    @Binding var selectedStatus: CharacterModel.Status?
    @Binding var selectedGender: CharacterModel.Gender?
    
    @State private var initialStatus: CharacterModel.Status?
    @State private var initialGender: CharacterModel.Gender?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Button(action: {
                    selectedStatus = initialStatus
                    selectedGender = initialGender
                    showSheet.toggle()
                }, label: {
                    Image(.closeIcon)
                })
                
                Spacer()
                Text("Filters")
                    .font(.custom("IBMPlexSans-Bold", size: 20))
                    .foregroundStyle(.accent)
                
                Spacer()
                
                Button(action: {
                    selectedStatus = nil
                    selectedGender = nil
                }, label: {
                    Text("Reset")
                        .font(.custom("IBMPlexSans-Regular", size: 14))
                        .foregroundStyle(selectedStatus != nil || selectedGender != nil ? .rick : .accent)
                })
            }
            
            VStack(alignment: .leading) {
                Text("Status")
                    .font(.custom("IBMPlexSans-Medium", size: 14))
                    .foregroundStyle(.accent)
                
                HStack {
                    ForEach(CharacterModel.Status.allCases, id: \.hashValue) { status in
                        RMStatusMenuButton(selectedStatus: $selectedStatus, currentStatus: status)
                    }
                }
                
            }
            
            VStack(alignment: .leading) {
                Text("Gender")
                    .font(.custom("IBMPlexSans-Medium", size: 14))
                    .foregroundStyle(.accent)
                
                HStack {
                    ForEach(CharacterModel.Gender.allCases, id: \.hashValue) { gender in
                        RMGenderMenuButton(selectedGender: $selectedGender, currentGender: gender)
                    }
                }
                
            }
            
            Button(action: {
                showSheet.toggle()
            }, label: {
                HStack {
                    Spacer()
                    Text("Apply")
                        .font(.custom("IBMPlexSans-Medium", size: 18))
                        .foregroundStyle(.accent)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    
                    Spacer()
                }
                .background(.rick)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            })
            Spacer()
        }
        .padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
        .background(.black)
        .onAppear {
            self.initialStatus = selectedStatus
            self.initialGender = selectedGender
        }
    }
 
}

#Preview {
    RMMenuFiltersView(showSheet: .constant(false), selectedStatus: .constant(nil), selectedGender: .constant(nil))
}
