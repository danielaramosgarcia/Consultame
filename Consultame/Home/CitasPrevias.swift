//
//  CitasPrevias.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 07/11/23.
//

import SwiftUI

struct CitasPrevias: View {
    @StateObject var citasArray = ConsultationViewModel()

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 350, alignment: .center)
                .foregroundColor(.white)
                .overlay(
                    VStack {
                        HStack {
                            Text("Citas Previas")
                                .padding(.all, 20)
                                .font(.title)
                            Spacer()
                        }
                        
                        ScrollView {
                            VStack{
                                if citasArray.consultations.isEmpty {
                                    ProgressView()
                                } else {
                                    ForEach(citasArray.consultations) { cita in
                                        CitasPreviasCards(cita: cita)
                                    }
                                }
                            }
                        }
                    }
                )
                .onAppear {
                    Task {
                        do {
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

