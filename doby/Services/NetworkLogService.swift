import Alamofire
import Foundation

final class NetworkLogService: EventMonitor {
    func requestDidFinish(_ request: Request) {
        print("[OUTGOING]: \(request.description)")
    }
    
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        print("𓂸 𓂸 𓂸NETWORK LOG START𓂸 𓂸 𓂸")
        if let url = response.response?.url {
            print("URL: \(url.absoluteString)")
        }
        
        if let statusCode = response.response?.statusCode {
            print("Status Code: \(statusCode)")
        }
        
        switch response.result {
        case .success(let value):
            print("Success: \(value)")
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
            if let data = response.data, let str = String(data: data, encoding: .utf8) {
                print("Server Error Body: \(str)")
            }
        }
        print("𓂸 𓂸 𓂸NETWORK LOG END𓂸 𓂸 𓂸")
    }
}
