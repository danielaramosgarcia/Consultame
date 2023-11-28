//
//  AllergiesViewModel.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 26/11/23.
//

import Foundation

class AllergiesViewModel : ObservableObject {
    @Published var alergies = [AllergiesModel]()
    
    let apiService = APIService.shared

    func getProfile() async throws {
        let apiService = APIService.shared
        apiService.getJSON(urlString: API.baseURL + "/allergy/" + String(User.user_id)) { (result: Result<[AllergiesModel],APIService.APIError>) in
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
