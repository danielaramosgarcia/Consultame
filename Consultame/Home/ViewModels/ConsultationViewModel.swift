
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










//import Foundation
//import SwiftUI
//
//class ConsultationViewModel: ObservableObject {
//    @Published var consultations: [ConsultationModel] = []
//    @Published var isLoading = false
//
//    func fetchAndProcessConsultations() {
//        isLoading = true
//        apiFetchConsultations { [weak self] result in
//            switch result {
//            case .success(let fetchedConsultations):
//                DispatchQueue.global(qos: .userInitiated).async {
//                    let processedConsultations = fetchedConsultations.map { consultation -> ConsultationModel in
//                        var consultationCopy = consultation
//                        if let createdAt = consultation.created_at {
//                            consultationCopy.processedCreatedAt = self?.formatDate(createdAt)
//                        }
//                        return consultationCopy
//                    }
//                    DispatchQueue.main.async {
//                        self?.consultations = processedConsultations
//                        self?.isLoading = false
//                    }
//                }
//            case .failure(let error):
//                // Handle errors, maybe with an error message
//                print("Error with handling Consultation API")
//                print(error.localizedDescription)
//                DispatchQueue.main.async {
//                    self?.isLoading = false
//                }
//            }
//        }
//    }
//
//    private func formatDate(_ dateString: String) -> String {
//        let isoFormatter = ISO8601DateFormatter()
//        guard let date = isoFormatter.date(from: dateString) else { return "Invalid date" }
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMM dd, yyyy" // Customize the date format
//        return dateFormatter.string(from: date)
//    }
//    
//    private func apiFetchConsultations(completion: @escaping (Result<[ConsultationModel], Error>) -> Void) {
//        let apiService = APIService.shared
//        apiService.getJSON(urlString: API.baseURL + "/consultation/\(User.user_id)") { (result: Result<[ConsultationModel],APIService.APIError>) in
//            switch result {
//            case .success(let consultationsArr):
//                DispatchQueue.main.async {
//                    self.consultations = consultationsArr
//                }
//            case .failure(let apiError):
//                switch apiError {
//                case .error(let errorString):
//                    DispatchQueue.main.async {
//                        print("Error")
//                        print(errorString)
//                    }
//                }
//            }
//        }
//    }
//    
//    func refreshConsultations() {
//        fetchAndProcessConsultations()
//    }
//}
//
