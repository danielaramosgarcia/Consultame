//
//  AllergiesViewModel.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 26/11/23.
//

import Foundation

class AllergiesViewModel : ObservableObject {
    @Published var alergies = [AllergiesModel]()
    var drugAllergies: [AllergiesModel] {
        return alergies.filter { $0.allergy.allergy_type_id == 2 }
    }

    var foodAllergies: [AllergiesModel] {
        return alergies.filter { $0.allergy.allergy_type_id == 1 }
    }

    var otherAllergies: [AllergiesModel] {
        return alergies.filter { $0.allergy.allergy_type_id != 1 && $0.allergy.allergy_type_id != 2 }
    }
    
    let apiService = APIService.shared

    func getAllergy() async throws {
        let apiService = APIService.shared
        apiService.getJSON(urlString: API.baseURL + "/user/allergy/" + String(User.user_id)) { (result: Result<[AllergiesModel],APIService.APIError>) in
            switch result {
            case .success(let alergies):
                DispatchQueue.main.async {
                    self.alergies = alergies
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
