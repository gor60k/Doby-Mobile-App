import Alamofire
import Foundation

final class NetworkLogService: EventMonitor {
    func requestDidFinish(_ request: Request) {
        print("Request Description: \(request.description)")
        
        if let httpRequest = request.request {
            print("Method:", httpRequest.httpMethod ?? "")
            print("URL:", httpRequest.url?.absoluteString ?? "")

            if let headers = httpRequest.allHTTPHeaderFields {
                print("Headers:", headers)
            }

            if let body = httpRequest.httpBody {
                if let jsonObject = try? JSONSerialization.jsonObject(with: body),
                   let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                   let prettyJSON = String(data: prettyData, encoding: .utf8) {
                    print("Request JSON:\n\(prettyJSON)")
                } else if let bodyString = String(data: body, encoding: .utf8) {
                    print("Request Body:\n\(bodyString)")
                }
            } else {
                print("Request Body: <empty>")
            }
        }
    }

    func request<Value>(
        _ request: DataRequest,
        didParseResponse response: DataResponse<Value, AFError>
    ) {
        print("URL:", response.request?.url?.absoluteString ?? "")

        if let status = response.response?.statusCode {
            print("Status:", status)
        }

        if let data = response.data,
           let body = String(data: data, encoding: .utf8) {
            print("Body:", body)
        }

        if let error = response.error {
            print("Error:", error)
        }
    }
}
