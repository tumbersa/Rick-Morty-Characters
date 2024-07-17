import SwiftUI

struct RMListView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<1) { index in
                    RMListCellView(character: .mock)
                        .contentShape(Rectangle())
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.black)
                        .listRowSeparator(.hidden)
                }
                
            }
            .listStyle(.plain)
            .padding([.top, .bottom])
            .scrollContentBackground(.hidden)
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
