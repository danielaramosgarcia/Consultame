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
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    func loginUser(email: String, password: String){
        YourNetworkManager.login(email: email, password: password) { result in
            switch result {
            case .success(let response):
                if let user = response["user"] as? [String: Any], let userId = user["id"] as? Int {
                    self.userId = userId
                    
                } else {
                    self.showAlert = true
                    self.alertMessage = "\(response)"
                }
            case .failure(let error):
                self.showAlert = true
                self.alertMessage = error.localizedDescription
            }
            
        }
    }


}
