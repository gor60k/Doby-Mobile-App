import Foundation

final class MultypartFormDataBuilder {
    private let boundary = UUID().uuidString
    private var body = Data()
    
    var contentType: String {
        "multipart/form-data; boundary=\(boundary)"
    }
    
    func addField(name: String, value: String) {
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n")
        body.append("\(value)\r\n")
    }
    
    func addFile(
        name: String,
        filename: String,
        mimetype: String,
        fileData: Data
    ) {
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n")
        body.append("Content-Type: \(mimetype)\r\n\r\n")
        body.append(fileData)
        body.append("\r\n")
    }
    
    func build() -> Data {
        var finalData = body
        finalData.append("--\(boundary)--\r\n")
        return finalData
    }
}

private extension Data {
    mutating func append(_ string: String) {
        append(string.data(using: .utf8)!)
    }
}
