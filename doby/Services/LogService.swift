import Foundation
import os

final class LogService {

    static let shared = LogService()

    private init() {}

    // MARK: - категории логов
    let network = Logger(subsystem: "com.doby.app", category: "network")
    let ui = Logger(subsystem: "com.doby.app", category: "ui")
    let database = Logger(subsystem: "com.doby.app", category: "database")
    let auth = Logger(subsystem: "com.doby.app", category: "auth")

    // MARK: - хелпперы
    func debug(_ message: String, logger: Logger) {
        logger.debug("\(message)")
    }

    func info(_ message: String, logger: Logger) {
        logger.info("\(message)")
    }

    func error(_ message: String, logger: Logger) {
        logger.error("\(message)")
    }

    // MARK: - обертка для ассинхронных задач
    func logAsync(
        _ name: String,
        logger: Logger,
        operation: () async throws -> Void
    ) async {
        logger.debug("\(name) START")

        do {
            try await operation()
            logger.info("\(name) SUCCESS")
        } catch {
            logger.error("\(name) ERROR: \(error.localizedDescription)")
        }

        logger.debug("\(name) END")
    }
}

extension LogService {
    func ui(_ message: String) {
        ui.debug("\(message)")
    }

    func network(_ message: String) {
        network.debug("\(message)")
    }
}
