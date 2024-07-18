//
//  RMNoMatchesView.swift
//  Rick & Morty Characters
//
//  Created by Глеб Капустин on 18.07.2024.
//

import SwiftUI

struct RMNoMatchesView: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            HStack {
                Image(.noMatches)
                    .resizable()
                    .frame(width: 261, height: 261)
                Spacer()
            }
            VStack(alignment: .center) {
                Text("No matches found")
                    .font(.custom("IBMPlexSans-Medium", size: 20))
                    
                 Text("Please try another filters")
                    .font(.custom("IBMPlexSans-Regular", size: 12))
                    
            }
            .foregroundStyle(.accent)
            .padding(.trailing, 46)
            .padding(.bottom, 27)
        }
        .background(.black)
    }
}

#Preview {
    RMNoMatchesView()
}
