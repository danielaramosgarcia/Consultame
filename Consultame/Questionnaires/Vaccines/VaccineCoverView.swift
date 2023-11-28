//
//  VaccineCoverview.swift
//  Consultame
//
//  Created by Alumno on 27/11/23.
//

import SwiftUI

struct VaccineCoverView: View {
    var body: some View {
        VStack{
            Text("Vacunas")
                .font(.system(size: 45, weight: .bold))

            
            Text("al día de hoy")
                .font(.system(size: 25, weight: .light))
            
            
            Image("VaccinePic")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 320)
                .padding()
            
            CustomButton(
                buttonColor : Color("AccentColor"),
                borderColor : Color.clear,
                text : "¡Vamos!",
                textColor : Color.white,
                destinationView: AnyView(VaccineQuestionView())
            )
            .padding(.top, 50)
            .padding(.horizontal, 60)
            
            CustomButton(
                buttonColor : Color.clear,
                borderColor : Color("AccentColor"),
                text : "Saltar",
                textColor : Color("AccentColor"),
                destinationView: AnyView(MainTabView())
            )
            .bold()
            .padding(.top, 20)
            .padding(.horizontal, 60)
            .navigationBarBackButtonHidden(true)
        }
       
    }
}

struct VaccineCoverView_Previews: PreviewProvider {
    static var previews: some View {
        VaccineCoverView()
    }
}
