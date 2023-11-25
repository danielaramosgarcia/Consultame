//
//  ProfileViewModel.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 23/11/23.
//

import Foundation

class ProfileViewModel : ObservableObject {
    @Published var profile = ProfileModel(id: 1, contact_name: "Daniela Ramos", birth_date: "07052003", height: "1.62", weight: "54",blood_type: Blood_typeModel(id: 1, type: "O+"), age: 5)
    
    let apiService = APIService.shared

    func getProfile() async throws {
        let apiService = APIService.shared
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
