//
//  ProfileViewModel.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 23/11/23.
//

import Foundation

class ProfileViewModel : ObservableObject {
    @Published var profile = ProfileModel(id: 1, contact_name: "ddd", birth_date: "hgg", height: "gg", weight: "hh", age: 5)
    
    let apiService = APIService.shared

    func getProfile() async throws {
        let apiService = APIService.shared
        // Don't forget to use your own key
        apiService.getJSON(urlString: API.baseURL + "/user/basics/" + String(User.user_id)) { (result: Result<ProfileModel,APIService.APIError>) in
            switch result {
            case .success(let profile):
                DispatchQueue.main.async {
                    self.profile = profile
                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    print(errorString)
                }
            }
        }
    }
    
    
}
