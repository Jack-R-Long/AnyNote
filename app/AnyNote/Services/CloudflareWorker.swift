//
//  CloudflareWorker.swift
//  AnyNote
//
//  Created by Jack long on 9/23/23.
//

import Foundation

class CloudflareWorkerService {
    static let shared = CloudflareWorkerService()
    private let baseUrl = URL(string: "https://voice-scribe.jack-attack.workers.dev")!
    
    private init() {}
    
    enum CloudflareWorkerError: Error {
        case serverError(String)
        case unknownError
    }
    
    func postMemo(_ memo: Memo, completion: @escaping (Result<Void, Error>) -> Void) {
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(memo)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    if response.statusCode == 200 {
                        completion(.success(()))

                    } else {
                        // Directly decode the server error without optional binding
                        let serverErrorMessage = String(data: data, encoding: .utf8)
                        let serverError = serverErrorMessage != nil ? CloudflareWorkerError.serverError(serverErrorMessage!) : CloudflareWorkerError.unknownError
                        completion(.failure(serverError))
                    }
                }
            }
        }
        task.resume()
    }
    
}
