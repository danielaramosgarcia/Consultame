//
//  ChatHistoryViewModel.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 28/11/23.
//

import Foundation

class ChatHistoryManager: ObservableObject {
    @Published var messagesArr = [MessageModel]()
    @Published var apiError: String?
    var consultation_id: Int
    
    init(consultation_id: Int) {
        self.consultation_id = consultation_id
    }
    
    
    func getMessages () {
        let apiService = APIService.shared
        // Don't forget to use your own key
        apiService.getJSON(urlString: API.baseURL + "/message/\(consultation_id)") { (result: Result<[MessageModel],APIService.APIError>) in
            switch result {
            case .success(let msgArr):
                DispatchQueue.main.async {
                    print("messages obtained")
                    self.messagesArr = msgArr
                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    DispatchQueue.main.async {
                        self.apiError = errorString
                        print(errorString)
                    }
                }
            }
        }
    }
}

