//
//  CitasPrevias.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 07/11/23.
//

import SwiftUI

struct CitasPrevias: View {
    @State var citasArray = ConsultationViewModel()
    
        var body: some View {
            ZStack{

                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 350, alignment: .center)
                    .foregroundColor(.white)

                    .overlay(
                        VStack{
                            HStack{
                                Text("Citas Previas")
                                    .padding(.all, 20)
                                    .font(.title)
                                Spacer()
                            }
                            
                            if citasArray.consultations.isEmpty {
                                Text("Esta vacio el Array")
                                    .foregroundStyle(.gray)
                            } else {
                                Text("hay datos compare")
                            }
                            Spacer()
                        }
                    )
                    .onAppear {
                        Task {
                            do {
                                print("Calling the API")
                                try await citasArray.getConsultations()
                            } catch {
                                // Handle any errors appropriately
                                print("Error fetching consultations: \(error)")
                            }
                        }
                    }
            }
        }
    }


struct CitasPrevias_Previews: PreviewProvider {
    static var previews: some View {
        CitasPrevias()
    }
}

