//
//  InicioSesionViewModel.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 29/11/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidData
}

class YourNetworkManager {
    static func login(email: String, password: String, completion: @escaping (Result<[String: Any], NetworkError>) -> Void) {
        guard let url = URL(string: API.baseURL + "/login") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let parameters: [String: Any] = ["email": email, "password": password]
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(.requestFailed(error)))
                    return
                }
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data, options:[]) as? [String: Any] {
                        completion(.success(jsonResult))
                    } else {
                        completion(.failure(.invalidData))
                    }
                } catch{
                    completion(.failure(.invalidData))
                }
            }.resume()
        } catch {
            completion(.failure(.invalidData))
        }
    }
}
