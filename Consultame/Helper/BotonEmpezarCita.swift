//
//  BotonEmpezarCita.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 07/11/23.
//

import SwiftUI

struct BotonEmpezarCita: View {
        var body: some View {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 350, height: 60, alignment: .center)
                .foregroundColor(.black)
                .overlay(
                    HStack {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                        Text("Empieza una cita")
                            .foregroundColor(.white)
                    }
                )
                .padding(.all, 20)
                .onTapGesture {
                    // Function goes here
                }
        }
    }

#Preview {
    BotonEmpezarCita()
}
