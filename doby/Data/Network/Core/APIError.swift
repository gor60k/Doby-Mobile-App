import Foundation

enum APIError: LocalizedError {
    case invalidResponse
    case httpError(statusCode: Int, url: String, method: String, body: String?)
    case decodingError(Error, url: String, method: String, responseBody: String?)
    case networkError(Error, url: String, method: String)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Сервер вернул некорректный ответ."

        case let .httpError(statusCode, url, method, body):
            var message = "HTTP ошибка\n"
            message += "Метод: \(method)\n"
            message += "URL: \(url)\n"
            message += "Код: \(statusCode)"

            if let body, !body.isEmpty {
                message += "\nОтвет сервера: \(body)"
            }

            return message

        case let .decodingError(error, url, method, responseBody):
            var message = "Ошибка декодирования\n"
            message += "Метод: \(method)\n"
            message += "URL: \(url)\n"
            message += "Причина: \(error.localizedDescription)"

            if let responseBody, !responseBody.isEmpty {
                message += "\nОтвет сервера: \(responseBody)"
            }

            return message

        case let .networkError(error, url, method):
            var message = "Ошибка сети\n"
            message += "Метод: \(method)\n"
            message += "URL: \(url)\n"
            message += "Причина: \(error.localizedDescription)"
            return message
        }
    }
}
