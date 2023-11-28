//
//  creaConsulta.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 26/11/23.
//

import Foundation



class ConsultationStore: ObservableObject {
    @Published var newConsultation: ConsultationModel?
    
    func createConsultation(consultation: ConsultationModel) {
        let apiService = APIService.shared
        let urlString = API.baseURL + "/consultation/"

        apiService.postJSON(urlString: urlString, requestBody: consultation) { [weak self] (result: Result<ConsultationModel, APIService.APIError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let createdConsultation):
                    self?.newConsultation = createdConsultation
                    print("Successfully created consultation with ID \(createdConsultation.id)")
                case .failure(let error):
                    print("Error occurred: \(error)")
                }
            }
        }
    }
}
