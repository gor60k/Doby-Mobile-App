import SwiftUI

extension EnvironmentValues {
    @Entry var appContainer: NAppContainer = NAppContainer()
    
    @Entry var userStorage: UserStorage = UserStorage()
    @Entry var petStorage: PetStorage = PetStorage()
}
