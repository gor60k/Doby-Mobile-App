import SwiftUI
import Combine

final class SettingsViewModel: ObservableObject {
    private var session = SessionService.shared
    
    @State var username: String = ""
    @State var name: String = ""
    @State var surname: String = ""
    @State var phone: String = ""
    
    @State var email: String = ""
    
    
}
