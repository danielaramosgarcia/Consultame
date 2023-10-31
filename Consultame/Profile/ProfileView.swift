//
//  ProfileView.swift
//  Consultame
//
//  Created by Alumno on 31/10/23.
//

import SwiftUI

struct ProfileView: View {
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    
    var body: some View {
        VStack {
            Text(User.user_name)
                .font(.title)
            ZStack{
                Circle()
                    .fill(Color.purple)
                    .frame(width:120)
                Text(String(User.user_name.first ?? " " ))
                    .foregroundColor(.white)
                    .font(.title)
                
            } // ZStack
            
            
            
            LazyVGrid(columns: columns, spacing: 20) {
                SectionCard(text: "Vacunas", image: "syringe")
                SectionCard(text: "Consultas", image: "stethoscope") // Imaginando que tienes otro símbolo.
                // Añade más tarjetas según lo necesites.
            }
            
            Spacer()

            
            
            
        } // VStack
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
