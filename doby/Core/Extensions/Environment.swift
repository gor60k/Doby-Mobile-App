import SwiftUI

extension EnvironmentValues {
    @Entry var appContainer: AppContainer = AppContainer()
    
    @Entry var userStorage: UserStorage = UserStorage()
    @Entry var petStorage: PetStorage = PetStorage()
}
