//
//  CommonTextInput.swift
//  Consultame
//
//  Created by Alumno on 31/10/23.
//

import SwiftUI

struct LightTextInput: TextFieldStyle {
        
    func _body(configuration: TextField<Self._Label>) -> some View{
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color("DarkGray"))
                .foregroundColor(Color.clear)
                .frame(height: 40)
            
            HStack {
                configuration
                    .foregroundColor(Color("DarkGray"))
            }
        }
    }
}
