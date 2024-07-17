import SwiftUI

struct RMListView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<3) { index in
                    Text("1")
                        .foregroundStyle(.accent)
                        .background(.green)
                }
                .listRowBackground(Color.black)
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
            .padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Rick & Morty Characters")
                        .font(.custom("IBMPlexSans-Bold", size: 24))
                        .foregroundStyle(.accent)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Color(UIColor.label))
        }
    }
}

#Preview {
    RMListView()
}
