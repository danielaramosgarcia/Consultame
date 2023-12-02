//
//  HabitsViewModel.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 25/11/23.
//

import Foundation

struct CreateHabitRequestBody : Codable {
    let user_id : Int
    let habit_id : Int

}

class HabitsViewModel : ObservableObject {
    @Published var habitsArray = [HabitsModel]()
    @Published var habitCreatedSuccessfully: Bool? = nil
    @Published var habits = [Habit]()
    
    let apiService = APIService.shared
    
    func getHabits() async throws {
        let apiService = APIService.shared
        apiService.getJSON(urlString: API.baseURL + "/user_habit/" + String(User.user_id)) { (result: Result<[HabitsModel],APIService.APIError>) in
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
    
    func getAllHabits() async throws {
        let apiService = APIService.shared
        apiService.getJSON(urlString: API.baseURL + "/habit/available/" + String(User.user_id)) { (result: Result<[Habit],APIService.APIError>) in
            switch result {
            case .success(let habits):
                DispatchQueue.main.async {
                    self.habits = habits
                    print("test de habits")
                    print(habits)
                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    print(errorString)
                }
            }
        }
    }
    
    func postHabitsToUser(habit_id: Int) async throws {
        guard let url = URL(string: API.baseURL + "/user_habit/" + String(User.user_id) ) else {
            self.habitCreatedSuccessfully = false
            print("invalid url")
            return
        }
        
        let body = CreateHabitRequestBody(user_id: User.user_id, habit_id: habit_id)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            self.allergyCreatedSuccessfully = false
            print("response error")
            return
        }
        
        
        self.habitCreatedSuccessfully = true
    }
    
    func deleteHabitsToUser(habitId: Int) async throws {
        guard let url = URL(string: API.baseURL + "/user_habit/" + String(habitId)) else {
            print("invalid url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("response error")
            return
        }
    }
    
}
