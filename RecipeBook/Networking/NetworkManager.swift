//
//  NetworkManager.swift
//  RecipeBook
//
//  Created by David Farcas on 16.08.2023.
//

import Foundation
import Alamofire

class NetworkManager {

    static let shared = NetworkManager()

    func fetchData(url: URLConvertible, completion: @escaping (Result<Data, Error>) -> Void) {
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
