//
//  FamilyCoverView.swift
//  Consultame
//
//  Created by Toño on 27/11/23.
//

import SwiftUI

struct FamilyCoverView: View {
    var body: some View {
        
        VStack{
            Text("Antecedentes")
                .font(.system(size: 45, weight: .bold))

            
            Text("medicos familiares")
                .font(.system(size: 25, weight: .light))
            
            
            Image("familypic")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 280)
                .padding()
            
            CustomButton(
                buttonColor : Color("AccentColor"),
                borderColor : Color.clear,
                text : "Añadir",
                textColor : Color.white,
                destinationView: AnyView(AddFamilyDiseaseToUserView())
            )
            .padding(.top, 50)
            .padding(.horizontal, 60)
            
            CustomButton(
                buttonColor : Color.clear,
                borderColor : Color("AccentColor"),
                text : "Siguiente",
                textColor : Color("AccentColor"),
                destinationView: AnyView(VaccineCoverView())
            )
            .bold()
            .padding(.top, 20)
            .padding(.horizontal, 60)
            .navigationBarBackButtonHidden(true)
        }
       
    }
}

struct FamilyCoverView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyCoverView()
    }
}

