//
//  APIservice.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 07/11/23.
//

import Foundation

public class APIService {
    public static let shared = APIService()
    
    public enum APIError: Error {
        case error(_ errorString: String)
    }
    
    public func getJSON<T: Decodable>(urlString: String,
completion: @escaping (Result<T,APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: ""))))
            return
        }
        var request = URLRequest(url: url)
        request.addValue("Bearer \(User.JWT)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.error("Error: \(error.localizedDescription)")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.error(NSLocalizedString("Error: Data us corrupt.", comment: ""))))
                return
            }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
                return
            } catch let decodingError {
                completion(.failure(APIError.error("Error: \(decodingError.localizedDescription)... ")))
                print(APIError.error("Error: \(decodingError.localizedDescription)... "))
                return
            }
            
        }.resume()
    }
    public func postJSON<T: Decodable, U: Encodable>(
        urlString: String,
        requestBody: U,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.error("Error: Invalid URL")))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(User.JWT)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(requestBody)
            request.httpBody = jsonData
        } catch {
            completion(.failure(.error("Error: Encoding request body")))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.error("Error: \(error.localizedDescription)")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.error(NSLocalizedString("Error: Data us corrupt.", comment: ""))))
                return
            }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let DecodingError.dataCorrupted(context) {
                print(context.codingPath, context.debugDescription)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error.localizedDescription)
            }

//            do {
//                let decodedData = try decoder.decode(T.self, from: data)
//                completion(.success(decodedData))
//                return
//            } catch let decodingError {
//                completion(.failure(APIError.error("Error: \(decodingError.localizedDescription)... ")))
//                return
//            }
        }.resume()
    }
    
//    public func deleteJSON<T: Decodable>(
//        urlString: String,
//        completion: @escaping (Result<T, APIError>) -> Void
//    ) {
//        guard let url = URL(string: urlString) else {
//            completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: ""))))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "DELETE"
//        request.addValue("Bearer \(User().JWT)", forHTTPHeaderField: "Authorization")
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                completion(.failure(.error("Error: \(error.localizedDescription)")))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(.error(NSLocalizedString("Error: Data is corrupt.", comment: ""))))
//                return
//            }
//
//            
//        }.resume()
//    }

}

