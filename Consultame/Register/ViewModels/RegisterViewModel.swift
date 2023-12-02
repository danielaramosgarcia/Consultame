//
//  RegisterViewModel.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 28/11/23.
//

import Foundation


class RegisterViewModel: ObservableObject {
    var UserInfo: SendUserModel
    
    
    init(UserInfo: SendUserModel) {
        self.UserInfo = UserInfo
    }
    
    func createUser() {
        let apiService = APIService.shared
        let urlString = API.baseURL + "/user/register"

        apiService.postJSON(urlString: urlString, requestBody: UserInfo) { (result: Result<ReceiveUserModel, APIService.APIError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let createdUser):
                    print(createdUser)
                    User.user_id = createdUser.user_id
                    User.JWT = createdUser.token
                case .failure(let error):
                    print("Error occurred at Register: \(error)")
                }
            }
        }
    }
    
}
