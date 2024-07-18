import SwiftUI

struct RMNoInternetView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Spacer().frame(height: 65)
                Image(.noInternet)
                    .resizable()
                    .frame(width: 263, height: 263)
                
                VStack {
                    VStack(alignment: .center, spacing: 0) {
                        Text("Network Error")
                            .font(.custom("IBMPlexSans-Bold", size: 28))
                            .foregroundStyle(.accent)
                        
                        Text("There was an error connecting.")
                            .font(.custom("IBMPlexSans-Regular", size: 20))
                            .foregroundStyle(.gray3)
                        
                        Text("Please check your internet.")
                            .font(.custom("IBMPlexSans-Regular", size: 20))
                            .foregroundStyle(.gray3)
                    }
                    
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Retry")
                            .padding()
                            .frame(width: 220)
                            .background(.rick)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    })
                }
                Spacer()
            }
            Spacer()
        }
        .background(.black)
    }
}

#Preview {
    RMNoInternetView()
}
