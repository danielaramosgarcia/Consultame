//
//  InicioSesionRealViewModel.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 29/11/23.
//

import Foundation
import Combine
import SwiftUI
class InicioSesionRealViewModel: ObservableObject {
    @Published var userId: Int?
    @State var username: String?
    @State var password: String?
    var user_info: ReceiveUserModel?
    
    // we need to: 1) Get the username and password from view, then call login API, put the info in the model, save to constants,do error handling, go to the next view
    
    func loginUser(email: String, password: String){

            
    }
    
    
    
    
}



