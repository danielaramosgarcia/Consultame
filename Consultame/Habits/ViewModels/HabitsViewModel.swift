//
//  HabitsViewModel.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 25/11/23.
//

import Foundation

class HabitsViewModel : ObservableObject {
    @Published var habitsArray = [HabitsModel]()
    
    let apiService = APIService.shared
    
    func getHabits() async throws {
        let apiService = APIService.shared
        apiService.getJSON(urlString: API.baseURL + "/user/habit/" + String(User.user_id)) { (result: Result<[HabitsModel],APIService.APIError>) in
            switch result {
            case .success(let habitsarr):
                DispatchQueue.main.async {
                    self.habitsArray = habitsarr
                    print("test de habits")
                    print(habitsarr)
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
