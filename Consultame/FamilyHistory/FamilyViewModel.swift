
import Foundation

class FamilyViewModel : ObservableObject {
    @Published var familyArray = [FamilyModel]()
    
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
    }
}
