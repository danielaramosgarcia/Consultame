//
//  ProfileView.swift
//  Consultame
//
//  Created by Alumno on 31/10/23.
//

import SwiftUI

struct ProfileView: View {
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
            
            Spacer()
            
            
            
        } // VStack
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
