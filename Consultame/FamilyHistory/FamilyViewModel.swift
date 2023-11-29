
import Foundation

struct CreateFamilyRequestBody : Codable {
    let user_id : Int
    let chronic_disease_id : Int
    let relationship_id : Int
    let description : String
    let diagnosis_date : Date

}

class FamilyViewModel : ObservableObject {
    @Published var familyArray = [FamilyModel]()
    @Published var familyCreatedSuccessfully: Bool? = nil
    @Published var diseases = [Disease]()

    let apiService = APIService.shared
    
    func getFamily() async throws {
        let apiService = APIService.shared
        apiService.getJSON(urlString: API.baseURL + "/family/" + String(User.user_id)) { (result: Result<[FamilyModel],APIService.APIError>) in
            switch result {
            case .success(let familyarr):
                DispatchQueue.main.async {
                    self.familyArray = familyarr
                    print("test de family")
                    print(familyarr)
                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    print(errorString)
                }
            }
        }
    } // getFamily
    
    
    func deleteFamilyFromUser(familyId: Int) async throws {
        guard let url = URL(string: API.baseURL + "/family/" + String(familyId)) else {
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
    
    func postFamilyToUser(chronic_disease_id: Int, relationship_id: Int, diagnosis_date: Date, description: String) async throws {
        guard let url = URL(string: API.baseURL + "/family" ) else {
            self.familyCreatedSuccessfully = false
            print("invalid url")
            return
        }
        
        let body = CreateFamilyRequestBody(user_id: User.user_id, chronic_disease_id: chronic_disease_id, relationship_id: relationship_id, description: description, diagnosis_date: diagnosis_date)
        
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
        
        
        self.familyCreatedSuccessfully = true
    }
    
    func getAllDisease() async throws {
        let apiService = APIService.shared
        apiService.getJSON(urlString: API.baseURL + "/disease/chronics" ) { (result: Result<[Disease],APIService.APIError>) in
            switch result {
            case .success(let diseases):
                DispatchQueue.main.async {
                    self.diseases = diseases
                    print("test de family")
                    print(diseases)
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
