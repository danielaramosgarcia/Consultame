//
//  CircleButton.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 06/11/23.
//

import SwiftUI

struct CircleButton: View {
    @State private var count = 0
//    let valoresBoton: CircularButton
    var icon: String
    var colorString: String
    var body: some View {
        
        Button(action:{
        count+=1
        }) {
            Image(systemName: icon)
                .resizable()
                .foregroundColor(.white)
                .font(.system(size: 60)) // Adjust the size as needed
                .padding()
                .background(Circle().fill(Color(hex: colorString))) // Circular background
//                .shadow(radius: 4) // Add a shadow for depth
            
        }
        .frame(width: 50, height: 50) // Set the fixed size
        .padding(3)
        
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(icon: "play.fill", colorString: "53d769")
    }
}
