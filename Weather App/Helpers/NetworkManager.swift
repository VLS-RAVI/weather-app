//
//  NetworkManager.swift
//  Weather App
//
//  Created by V L S RAVI on 15/05/21.
//

import Foundation

class NetworkManager {
    
    enum Result<value>{
        case success(value)
        case failure(Error?)
    }
    
    let session = URLSession.shared
    
    func call<T: Codable>(urlRequest: URLRequest, completion: @escaping (_ result: Result<T>) -> Void) -> URLSessionTask {
        let task = session.dataTask(with: urlRequest) { (data, _, error) in
            
            let decoder = JSONDecoder()

            if let e = error {
                completion(Result.failure(e))
            }
            
            guard let d = data, let res = try? decoder.decode(T.self, from: d) else {
                completion(Result.failure(error))
                print("data cannot be parsed")
                return
            }
            completion(Result.success(res))
        }
        task.resume()
        return task
    }
}
