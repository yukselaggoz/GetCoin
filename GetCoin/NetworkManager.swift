//
//  NetworkManager.swift
//  GetCoin
//
//  Created by Yüksel Ağgöz on 16.11.2020.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    static let instance = NetworkManager()
    static let baseUrl = "https://api.coinranking.com/v1/public/"
    let headers: HTTPHeaders = [
        "packageName": Bundle.main.bundleIdentifier!
    ]
    
    public func fetchGetRequest<T: Codable>(endpoint: String, parameters: [String: Any], model: T.Type, completion: @escaping (AFResult<Codable>) -> Void) {
        AF.request(NetworkManager.baseUrl + endpoint,
                   method: .get,
                   parameters: parameters,
                   headers: headers,
                   interceptor: nil
        ) { (urlRequest) in
//            urlRequest.timeoutInterval = 5
//            urlRequest.allowsConstrainedNetworkAccess = false
        }.validate().responseJSON { (response) in
            switch response.result {
            case .success(let value as [String: AnyObject]):
                do {
                    let responseJsonData = JSON(value)
                    let responseModel = try JSONDecoder().decode(model.self, from: responseJsonData.rawData())
                    debugPrint("Success : \(responseModel)")
                    completion(.success(responseModel))
                }
                catch let parsingError {
                    debugPrint("Success (error): \(parsingError)")
                }
            case .failure(let error):
                debugPrint("Failure \(error)")
                completion(.failure(error))
            default:
                fatalError("Fatal error.")
            }
        }
    }
    
}
