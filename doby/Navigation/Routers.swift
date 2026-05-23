import Observation

@Observable
final class AuthRouter: AppRouter<AuthRoute> {}

@Observable
final class ProfileRouter: AppRouter<ProfileRoute> {}

@Observable
final class PetRouter: AppRouter<PetRoute> {}

@Observable
final class SettingsRouter: AppRouter<SettingsRoute> {}
