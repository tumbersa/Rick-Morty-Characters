import SwiftUI


struct RMStatusMenuButton: View {
    
    @Binding var selectedStatus: CharacterModel.Status?
    var currentStatus: CharacterModel.Status
    
    private var isSelected: Bool {
        selectedStatus == currentStatus
    }
    
    var body: some View {
        Button(action: {
            selectedStatus = currentStatus
        }, label: {
            HStack{
                Text(currentStatus.getRawValue())
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
    RMStatusMenuButton(selectedStatus: .constant(nil), currentStatus: .alive)
}
