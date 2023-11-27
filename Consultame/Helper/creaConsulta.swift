//
//  creaConsulta.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 26/11/23.
//

import Foundation


func createConsultation(consultation: ConsultationModel) {
    let apiService = APIService.shared
    let urlString = API.baseURL + "/consultation/"
    
    apiService.postJSON(urlString: urlString, requestBody: consultation) { (result: Result<ConsultationModel, APIService.APIError>) in
        switch result {
        case .success(let newConsultation):
            // Handle the success case, e.g., update UI or state
            print("Successfully created consultation with ID \(newConsultation.id)")
        case .failure(let error):
            // Handle the error case
            print("Error occurred: \(error)")
        }
    }
}
