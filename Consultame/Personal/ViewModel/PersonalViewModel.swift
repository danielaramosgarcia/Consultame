//
//  PersonalViewModel.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 26/11/23.
//

import Foundation

class PersonalViewModel : ObservableObject {
    @Published var personal = PersonalModel( id : 1, email : "email", birth_date : "07052003", phone_number : 9611382118, sex_id : 1, height : 162, weight : 55, blood_type : Blood_typeModel(id: 1, type: "O+"), direction : "Magma Towers")
    
    let apiService = APIService.shared

    func getProfile() async throws {
        let apiService = APIService.shared
        apiService.getJSON(urlString: API.baseURL + "/personal/" + String(User.user_id)) { (result: Result<PersonalModel,APIService.APIError>) in
            switch result {
            case .success(let personal):
                DispatchQueue.main.async {
                    self.personal = personal
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
