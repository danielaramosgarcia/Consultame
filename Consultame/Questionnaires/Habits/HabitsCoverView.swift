//
//  FamilyCoverView.swift
//  Consultame
//
//  Created by Toño on 27/11/23.
//

import SwiftUI

struct HabitsCoverView: View {
    var body: some View {
        
        VStack{
            Text("Hábitos")
                .font(.system(size: 45, weight: .bold))

            
            Text("saludables y no saludables")
                .font(.system(size: 25, weight: .light))
            
            
            Image("habits")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 280)
                .padding()
            
            CustomButton(
                buttonColor : Color("AccentColor"),
                borderColor : Color.clear,
                text : "¡Vamos!",
                textColor : Color.white,
                destinationView: AnyView(HabitsQuestionsView())
            )
            .padding(.top, 50)
            .padding(.horizontal, 60)
            
            CustomButton(
                buttonColor : Color.clear,
                borderColor : Color("AccentColor"),
                text : "Saltar",
                textColor : Color("AccentColor"),
                destinationView: AnyView(AllergiesCoverView())
            )
            .bold()
            .padding(.top, 20)
            .padding(.horizontal, 60)
            .navigationBarBackButtonHidden(true)
        }
       
    }
}

struct HabitsCoverView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsCoverView()
    }
}

