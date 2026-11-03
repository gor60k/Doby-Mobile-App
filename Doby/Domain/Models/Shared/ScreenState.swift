enum ScreenState {
    case idle
    case loading
    case success
    case empty
    case error(Error)
}
