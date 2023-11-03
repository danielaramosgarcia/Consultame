//
//  CommonTextInput.swift
//  Consultame
//
//  Created by Alumno on 31/10/23.
//

import SwiftUI

struct CommonTextInput: TextFieldStyle {
    
    let iconImage : String
    
    func _body(configuration: TextField<Self._Label>) -> some View{
        ZStack {
            RoundedRectangle(cornerRadius: 5.0)
                .foregroundColor(Color ("Gray text box"))
                .frame(height: 50)
            
            HStack {
                configuration
                    .foregroundColor(Color("Gray text"))
                Image(systemName: iconImage)
                
            }
            .padding()
            .foregroundColor(Color("Gray text"))
            
        }
    }
}
