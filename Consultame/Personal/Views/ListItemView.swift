//
//  ListItemView.swift
//  Consultame
//
//  Created by Alumno on 29/11/23.
//

import SwiftUI

struct ListItemView: View {
    var label: String
    @State var value: String
    var showEditButton: Bool
    @State private var isEditing = false

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

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(label: "Linea calle 1", value: "",showEditButton: true)
    }
}
