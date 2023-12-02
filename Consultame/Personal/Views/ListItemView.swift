import SwiftUI

struct ListItemView: View {
    var label: String
    @Binding var value: String
    var showEditButton: Bool
    @Binding var isEditing: Bool

    var body: some View {
        HStack {
            if isEditing {
                TextField("\(label)", text: $value)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text("\(label): \(value)")
            }
            Spacer()
            if showEditButton {
                Button(action: {
                    isEditing.toggle()
                }) {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .frame(height: 50)
        .background(Rectangle().fill(Color.white))
    }
}

