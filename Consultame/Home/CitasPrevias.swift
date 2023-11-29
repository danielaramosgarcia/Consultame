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
                        
                        List {
                            ForEach(citasArray.consultations) { cita in
                                CitasPreviasCards(cita: cita)
                            }
                            .onDelete(perform: deleteConsultation)
                            .padding(.vertical,-4)
                            .padding(.horizontal,-18)
                            
                            
                        }
                        .listStyle(PlainListStyle())

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

    func deleteConsultation(at offsets: IndexSet) {
        let idsToDelete = offsets.map { citasArray.consultations[$0].id! }
        
        Task {
            for id in idsToDelete {
                do {
                    try await citasArray.deleteConsultations(id: id)
                } catch {
                    print("Error deleting consultation: \(error)")
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

