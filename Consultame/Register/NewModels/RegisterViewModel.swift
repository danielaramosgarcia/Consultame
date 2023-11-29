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
        let urlString = API.baseURL + "/user"

        apiService.postJSON(urlString: urlString, requestBody: UserInfo) { (result: Result<ReceiveUserModel, APIService.APIError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let createdUser):
                    User.user_id = createdUser.user.id
                    User.JWT = createdUser.token
                    User.user_name = createdUser.user.name
                    print("Successfully created User with ID \(User.user_id) and token \(User.JWT)")
                case .failure(let error):
                    
                    print("Error occurred: \(error)")
                    
                }
            }
        }


    }
    
}
