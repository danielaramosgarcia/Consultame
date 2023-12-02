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
            } catch{
                do {
                    // If the decoding to the expected model failed, try to decode to the ErrorModel
                    let errorResponse = try decoder.decode(ErrorModel.self, from: data)
                    let errorMessage = errorResponse.error_string ?? errorResponse.message
                    print("Error Response: \(errorResponse), Error Message: \(errorMessage)")
                    completion(.failure(.error("Error: \(errorMessage)")))
                }
                catch let DecodingError.dataCorrupted(context) {
                    let errorDescription = "Data Corrupted: \(context.debugDescription), path: \(context.codingPath)"
                    print(errorDescription)
                    completion(.failure(.error(errorDescription)))
                } catch let DecodingError.keyNotFound(key, context) {
                    let errorDescription = "Key '\(key)' not found: \(context.debugDescription), path: \(context.codingPath)"
                    print(errorDescription)
                    completion(.failure(.error(errorDescription)))
                } catch let DecodingError.valueNotFound(value, context) {
                    let errorDescription = "Value '\(value)' not found: \(context.debugDescription), path: \(context.codingPath)"
                    print(errorDescription)
                    completion(.failure(.error(errorDescription)))
                } catch let DecodingError.typeMismatch(type, context)  {
                    let errorDescription = "Type '\(type)' mismatch: \(context.debugDescription), path: \(context.codingPath)"
                    print(errorDescription)
                    completion(.failure(.error(errorDescription)))
                } catch {
                    let errorDescription = "Unexpected error: \(error.localizedDescription)"
                    print(errorDescription)
                    completion(.failure(.error(errorDescription)))
                }
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
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.error("Error: Unable to get HTTP response")))
                return
            }
            switch httpResponse.statusCode {
            case 200...299:
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch{
                    do {
                        // If the decoding to the expected model failed, try to decode to the ErrorModel
                        let errorResponse = try decoder.decode(ErrorModel.self, from: data)
                        let errorMessage = errorResponse.error_string ?? errorResponse.message
                        print("Error Response: \(errorResponse), Error Message: \(errorMessage)")
                        completion(.failure(.error("Error: \(errorMessage)")))
                    }
                    catch let DecodingError.dataCorrupted(context) {
                        let errorDescription = "Data Corrupted: \(context.debugDescription), path: \(context.codingPath)"
                        print(errorDescription)
                        completion(.failure(.error(errorDescription)))
                    } catch let DecodingError.keyNotFound(key, context) {
                        let errorDescription = "Key '\(key)' not found: \(context.debugDescription), path: \(context.codingPath)"
                        print(errorDescription)
                        completion(.failure(.error(errorDescription)))
                    } catch let DecodingError.valueNotFound(value, context) {
                        let errorDescription = "Value '\(value)' not found: \(context.debugDescription), path: \(context.codingPath)"
                        print(errorDescription)
                        completion(.failure(.error(errorDescription)))
                    } catch let DecodingError.typeMismatch(type, context)  {
                        let errorDescription = "Type '\(type)' mismatch: \(context.debugDescription), path: \(context.codingPath)"
                        print(errorDescription)
                        completion(.failure(.error(errorDescription)))
                    } catch {
                        let errorDescription = "Unexpected error: \(error.localizedDescription)"
                        print(errorDescription)
                        completion(.failure(.error(errorDescription)))
                    }
                }
//            case 404:
//                completion(.failure(.statusCode(404, "Not Found")))
//            case 401:
//                completion(.failure(.statusCode(401, "Unauthorized")))
            default:
                completion(.failure(.error("Error: Unexpected HTTP response status code \(httpResponse.statusCode)")))

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



public enum APIError: Error {
    case error(_ errorString: String)
    case statusCode(_ code: Int, _ message: String) // Add a case to include status code
    case notFound
    case unauthorized
    // Other custom status code cases can be added here
}

