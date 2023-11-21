//
//  ConsultationData.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 09/11/23.
//

import Foundation



class ConsultationViewModel: ObservableObject {
    @Published var consultations = [ConsultationModel]()
    @Published var apiError: String?

    // This Function is getting all the consultations in the DB, not only the ones from a specific user
    func getConsultations() async throws {
        let apiService = APIService.shared
        // Don't forget to use your own key
        apiService.getJSON(urlString: API.baseURL + "/consultation/\(User.user_id)") { (result: Result<[ConsultationModel],APIService.APIError>) in
            switch result {
            case .success(let consultationsArr):
                print("success")
                DispatchQueue.main.async {
                    self.consultations = consultationsArr
                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    DispatchQueue.main.async {
                        self.apiError = errorString
                        print("Error")
                        print(errorString)
                    }
                }
            }
        }
    }
    

    
}

