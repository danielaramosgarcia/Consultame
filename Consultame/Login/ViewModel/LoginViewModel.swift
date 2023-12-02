//
//  InicioSesionRealViewModel.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 29/11/23.
//

import Foundation
import Combine
import SwiftUI
class LoginViewModel: ObservableObject {
    @Published var isSuccess: Bool = false  // published property for navigation
    @Published var isError: Bool = false     // To handle error state

    

    //    var user_info: ReceiveUserModel?
    var apiService = APIService()
    let urlString = API.baseURL + "/user/login"
    
    // we need to: 1) Get the username and password from view, then call login API, put the info in the model, save to constants,do error handling, go to the next view
    
    func loginUser(userLogin: LoginModel){
        apiService.postJSON(urlString: urlString, requestBody: userLogin) { (result: Result<ReceiveUserModel, APIService.APIError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let loginUser):
                    print(loginUser)
                    User.user_id = loginUser.user_id
                    User.JWT = loginUser.token
                    self.isSuccess = true  // Update the success state
                case .failure(let error):
                    print("Error occurred at Login: \(error)")
                    self.isError = true   // Update the error state if needed for view feedback
                }
            }
        }
    }
    
    
    
}



