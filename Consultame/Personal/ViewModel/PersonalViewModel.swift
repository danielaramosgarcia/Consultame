//
//  PersonalViewModel.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 26/11/23.
//

import Foundation

class PersonalViewModel : ObservableObject {

    struct EditWeightFromUser : Codable {
        let weight : String
    }
    
    @Published var personal = PersonalModel(
        id: 1,
        email: "dummy@email.com",
        name: "Dummy Name",
        birth_date: "2003-11-23T00:00:00.000Z",
        phone_number: "1234567890",
        sex: SexModel(id: 1, type: "Male"),
        height: "175",
        weight: "70",
        blood_type: Blood_typeModel(id: 1, type: "O+"),
        addresses: [DireccionModel(id: 1, street_line_1: "123 Main St", street_line_2: "Apt 4", city: "Dummy City", state_province_region: "Dummy State", postal_code: "12345", country: "Dummy Country", additional_info: "Dummy Info")]
    )
    
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
    
    func editWeightToUser(weightId: String) async throws {
        guard let url = URL(string: API.baseURL + "user/weight/" + String(User.user_id)) else {
            print("invalid url")
            return
        }
        
        let body = EditWeightFromUser(weight: weightId)

        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("response error")
            return
        }
    }
    
}
