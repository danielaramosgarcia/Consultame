//
//  MessageRowView.swift
//  Consultame
//
//  Created by Alumno on 20/11/23.
//

import SwiftUI

struct MessageRowView: View {
    var message: MessageModel

    var body: some View {
        HStack {
            if message.is_from_user {
                Spacer()
                Text(message.message)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            } else {
                Text(message.message)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                Spacer()
            }
        }
    }
}

struct MessageRowView_Previews: PreviewProvider {
    static var previews: some View {
        let message = MessageModel(id: 0, message: "hola mundo", is_starred: true, is_from_user: true, created_at: "11-11-2003", consultation_id: 1)
        
        MessageRowView(message: message)
    }
}
