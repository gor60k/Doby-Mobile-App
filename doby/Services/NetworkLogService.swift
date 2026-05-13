import Alamofire
import Foundation

final class NetworkLogService: EventMonitor {
    func requestDidFinish(_ request: Request) {
        print("Request Description: \(request.description)")
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
