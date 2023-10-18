import Foundation
import SwiftUI

class VaccineViewModel : ObservableObject {
    @Published var vaccineArr = [VaccineModel]()
    
    
    func getVaccines() async throws {
        guard let url = URL(string: API.baseURL + "/vaccine") else {
            print("invalid url")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard(response as? HTTPURLResponse)?.statusCode == 200 else {
            print("response error")
            return
        }
        
        let results = try JSONDecoder().decode([VaccineModel].self, from: data)
        
        DispatchQueue.main.async {
            self.vaccineArr = results
        
        }
        
    }
    
    func setVaccineToUser() async throws {
        print("codigo")
    }
    
}


