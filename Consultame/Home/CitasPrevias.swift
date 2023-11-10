//
//  CitasPrevias.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 07/11/23.
//

import SwiftUI

struct CitasPrevias: View {
    @State var citasPrevias = [1,2,2,3]
    
        var body: some View {
            ZStack{

                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 350, alignment: .center)
                    .foregroundColor(.white)

                    .overlay(
                        VStack{
                            Text("Citas Previas")
                                .padding(.all, 20)
                            if citasPrevias.isEmpty {
                                Text("Esta vacio el Array")
                                    .foregroundStyle(.gray)
                            } else {
                                
                                CitasPreviasCards()
                                CitasPreviasCards()
                                
                            }
                            Spacer()
                        }
                    )
            }
        }
    }


#Preview {
    
    CitasPrevias()
}
