import Foundation
import Observation

@Observable
final class WebSocketService {
    var isConnected = false
    
    var onMessage: ((Message) -> Void)?
    
    private var socketTask: URLSessionWebSocketTask?
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private var socketURL: URL? {
        var components = URLComponents(
            url: APIConstants.getImageBaseURL(),
            resolvingAgainstBaseURL: false
        )
        
        if components?.scheme == "https" {
            components?.scheme = "wss"
        } else {
            components?.scheme = "ws"
        }
        
        components?.path = "chats/routing/"
        
        return components?.url
    }
    
    func connect() {
        guard socketTask == nil else { return }
        guard let socketURL else { return }
        
        let url = URL(string: socketURL.absoluteString)!
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 30
        
        socketTask = URLSession.shared.webSocketTask(with: request)
        socketTask?.resume()
        
        isConnected = true
        
        listen()
        
        print("WebSocket connected")
    }
    
    func disconnect() {
        socketTask?.cancel(with: .goingAway, reason: nil)
        socketTask = nil
        
        isConnected = false
        
        print("WebSocket disconnected")
    }
    
    func send(message: Message) {
        
        guard let socketTask else {
            print("Socket is nil")
            return
        }
        
        do {
            let data = try encoder.encode(message)
            
            socketTask.send(.data(data)) { error in
                if let error {
                    print(error)
                    return
                }
            }
        } catch {
            print("Ошибка кодирования: \(error)")
        }
    }
    
    private func listen() {
        socketTask?.receive { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let message):
                switch message {
                case .data(let data):
                    self.handleData(data)
                case .string(let text):
                    self.handleString(text)
                @unknown default:
                    break
                }
                self.listen()
            case .failure(let error):
                print("Receive Error: \(error)")
                self.isConnected = false
            }
        }
    }
    
    private func handleData(_ data: Data) {
        do {
            let message = try decoder.decode(Message.self, from: data)
            
            DispatchQueue.main.async {
                self.onMessage?(message)
            }
        } catch {
            print("Ошибка декодирования: \(error)")
        }
    }
    
    private func handleString(_ text: String) {
        print("Received: \(text)")
    }
}
