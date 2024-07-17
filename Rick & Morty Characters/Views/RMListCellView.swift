import SwiftUI

struct RMListCellView: View {
    let character: CharacterModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: character.imagePath)) { phase in
                phase.image?
                    .resizable()
                    .frame(width: 84, height: 64)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
            }
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.custom("IBMPlexSans-Medium", size: 18))
                    .foregroundStyle(.accent)
                
                HStack(spacing: 4) {
                    Text(character.status.rawValue)
                        .foregroundStyle(character.statusColor)
                    Text("•")
                        .foregroundStyle(.accent)
                    Text(character.species)
                        .foregroundStyle(.accent)
                }
                .font(.custom("IBMPlexSans-SemiBold", size: 12))
                
                Text(character.gender.rawValue)
                    .font(.custom("IBMPlexSans-Regular", size: 12))
                    .foregroundStyle(.accent)
            }
            
            Spacer()
        }
        .padding()
        .background(.black2)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}

#Preview {
    RMListCellView(character: CharacterModel.mock)
}
