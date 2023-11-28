//
//  PersonalViewModel.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 26/11/23.
//

import Foundation

class PersonalViewModel : ObservableObject {
    @Published var personal = PersonalModel(id : 1, email : "email", password : "123", name : "Dani Ramos", birth_date : "07052003", phone_number : "9611382118", sex_id : 1, weight: 55, height : 162, address : DireccionModel(id : 1, street_line_1: "agua pasa por mi casa", street_line_2: "cate de mi corazon", city: "Tuxtla Gtz", state_providence: "Chiapas", postal_code: "5555", country: "mexico", additional_info: "lmao", user_id: 1))
    
    let apiService = APIService.shared

    func getPersonal() async throws {
        let apiService = APIService.shared
        apiService.getJSON(urlString: API.baseURL + "/user/details/" + String(User.user_id)) { (result: Result<PersonalModel,APIService.APIError>) in
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
