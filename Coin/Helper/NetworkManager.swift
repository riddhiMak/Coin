
import Foundation
import UIKit
import Alamofire

enum NetworkRequestStatus {
    case success
    case failure(Error)
}

struct NetworkRequest {
    var url: String
    var requestType: HTTPMethod
    var parameater: [String:Any]?
}

class NetworkManager: NSObject {
    
    static let shared: NetworkManager = NetworkManager()
    
    private func callAPI(request: NetworkRequest,
                         completionHandler: @escaping(_ response: [String:Any]?, _ status: NetworkRequestStatus) -> Void){
        
        print("\n\n----------------")
        print(request.url,"\n")
        request.parameater?.forEach { print("\($0): \($1)") }
        print("----------------\n\n")
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        guard let url = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{
            completionHandler(nil, .failure(NSError(domain: "", code:400, userInfo: [NSLocalizedDescriptionKey:"Something Wrong!! Please Try Again"]) as Error))
            return
        }
        
        AF.request(
            url,
            method: request.requestType,
            parameters: request.parameater,
            encoding: URLEncoding.queryString,
            headers: headers
        ).responseJSON { (response) in
            
            switch response.result {
            case .success:
                let dict = response.value as! [String:Any]
                completionHandler(dict, .success)
                
            case let .failure(error):
                completionHandler(nil, .failure(error))
            }
        }
    }
}

extension NetworkManager{
    func getCoinIDAPI(parameater: [String:Any],
                     success: @escaping (_ response: [String:Any]) -> Void,
                     failure: @escaping (_ error: Error?) -> Void){
        
        let request = NetworkRequest(url: Url.topCoinID.absoluteString!, requestType: .get, parameater: parameater)
        callAPI(request: request) { (data, status) in
            switch status {
            case .success:
                
                guard let data = data  else {
                    failure(nil)
                    return
                }
                
                success(data)
                break
                
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
}

