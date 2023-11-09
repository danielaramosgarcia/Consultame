import Foundation
import SwiftUI
import Combine

struct CreateContactRequestBody : Codable {
    let contact_name : String
    let phone_number : String
    let email : String
    let relationship_id : Int
    let user_id : Int
}

class ContactsViewModel : ObservableObject {
    @Published var contactsArr = [ContactModel]()
    @Published var relationshipsArr = [RelationshipModel]()
    @Published var userCreatedSuccessfully: Bool? = nil
    
    let apiService = APIService.shared

//    func getContacts() async throws {
//        guard let url = URL(string: API.baseURL + "/contacts/" + String(User.user_id)) else {
//            print("invalid url")
//            return
//        }
//
//        let urlRequest = URLRequest(url: url)
//
//        let (data, response) = try await URLSession.shared.data(for: urlRequest)
//
//        guard(response as? HTTPURLResponse)?.statusCode == 200 else {
//            print("response error")
//            return
//        }
//
//        let results = try JSONDecoder().decode([ContactModel].self, from: data)
//
//        DispatchQueue.main.async {
//            self.contactsArr = results
//
//        }
//    }
    
//    func getContacts() async throws {
//        guard let url = URL(string: API.baseURL + "/contacts/" + String(User.user_id)) else {
//            print("invalid url")
//            return
//        }
//
//        let urlRequest = URLRequest(url: url)
//
//        let (data, response) = try await URLSession.shared.data(for: urlRequest)
//
//        guard(response as? HTTPURLResponse)?.statusCode == 200 else {
//            print("response error")
//            return
//        }
//
//        let results = try JSONDecoder().decode([ContactModel].self, from: data)
//
//        DispatchQueue.main.async {
//            self.contactsArr = results
//
//        }
//    }

    func getContacts() async throws {
        let apiService = APIService.shared
        // Don't forget to use your own key
        apiService.getJSON(urlString: API.baseURL + "/contacts/" + String(User.user_id)) { (result: Result<[ContactModel],APIService.APIError>) in
            switch result {
            case .success(let contactsArr):
                DispatchQueue.main.async {
                    self.contactsArr = contactsArr
                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    print(errorString)
                }
            }
        }
    }
    
    func getRelationships() async throws {
        guard let url = URL(string: API.baseURL + "/relationship") else {
            print("invalid url")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard(response as? HTTPURLResponse)?.statusCode == 200 else {
            print("response error")
            return
        }
        
        let results = try JSONDecoder().decode([RelationshipModel].self, from: data)
        
        DispatchQueue.main.async {
            self.relationshipsArr = results
        }
    }
    
    
    func createContact(contactName: String, phoneNumber: String, email: String, relationshipId: Int) async throws {
        guard let url = URL(string: API.baseURL + "/contacts") else {
            self.userCreatedSuccessfully = false
            print("invalid url")
            return
        }
        
        let body = CreateContactRequestBody(contact_name: contactName, phone_number: phoneNumber, email: email, relationship_id: relationshipId, user_id: User.user_id)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            self.userCreatedSuccessfully = false
            print("response error")
            return
        }
        
        
        self.userCreatedSuccessfully = true
    }
    
    func deleteContactFromUser(contactId: Int) async throws {
        guard let url = URL(string: API.baseURL + "/contacts/" + String(contactId)) else {
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


