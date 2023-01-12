//
//  NetworkManager.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import Alamofire

enum ResponseStatusCode: Int {
    case success = 200
    case badRequest = 401
}

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

class NetworkManager {
    
    static let instance = NetworkManager()
    
    func request<T: Decodable>(_ strURL: String, parameters: [String : Any]?, method: HTTPMethod, type: T.Type, viewController: UIViewController, api_response: @escaping (BaseModel<T>?) -> Void, hasLoading: Bool = true){
        
        
        if hasLoading {
            Loading().startProgress(viewController)
        }
        
        guard Connectivity.isConnectedToInternet else {
            let vc = CheckConnection().loadFromNib()
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            DispatchQueue.main.async {
                viewController.present(vc, animated: true, completion: nil)
            }
            return
        }
        
        let headers = getHeaders()
        let parameters = parameters ?? [:]
        
#if DEBUG
        print("Headers:", headers)
        print("Parameters:", parameters)
#endif
        
        AF.request(strURL, method: method, parameters: parameters, headers: headers).responseDecodable(of: BaseModel<T>.self) { (response) -> Void in
            //Do what ever you want to do with response
#if DEBUG
            print(response.debugDescription)
            print(response.description)
#endif
            switch response.result {
            case .success:
                let resJson = response.data
                do {
                    let model = try JSONDecoder().decode(BaseModel<T>.self, from: resJson!)
                    api_response(model)
//                    guard let statusCode = model.count , let responseStatusCode = ResponseStatusCode(rawValue: statusCode) else { return }
//                    switch responseStatusCode {
//                    case .success:
//                        api_response(model)
//                    case .badRequest:
//                        viewController.swiftMessage(title: "Count Of Recipe\(statusCode)", body: " Error ", color: .error, layout: .messageView, style: .top)
//                    }
                } catch DecodingError.keyNotFound(let key, let context) {
                    SharedHandler.instance.getRootVC().swiftMessage(title: "\(key)", body: "\(context.codingPath)", color: .error, layout: .messageView, style: .bottom)
                } catch DecodingError.typeMismatch(let type, let context) {
                    print(type, context.codingPath)
                    SharedHandler.instance.getRootVC().swiftMessage(title: "\(type)", body: "\(context.codingPath)", color: .error, layout: .messageView, style: .bottom)
                } catch DecodingError.valueNotFound(let type, let context) {
                    SharedHandler.instance.getRootVC().swiftMessage(title: "\(type)", body: "\(context.codingPath)", color: .error, layout: .messageView, style: .bottom)
                } catch DecodingError.dataCorrupted(_) {
                    SharedHandler.instance.getRootVC().swiftMessage(title: "Invalid JSON", body: "Invalid JSON", color: .error, layout: .messageView, style: .bottom)
                } catch {
                    SharedHandler.instance.getRootVC().swiftMessage(title: "Error", body: error.localizedDescription, color: .error, layout: .messageView, style: .bottom)
                }
                Loading().finishProgress(viewController)
                
            case let .failure(error):
                
                SharedHandler.instance.getRootVC().swiftMessage(title: "Error", body: error.localizedDescription, color: .error, layout: .messageView, style: .bottom)
                Loading().finishProgress(viewController)
                
                break
            }
        }
        
    }
    
    
    func getHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "platform": "iOS",
            "Language": "en",
            "Accept": "application/json",
        ]
        return headers
    }
    
}
