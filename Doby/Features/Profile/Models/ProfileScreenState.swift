enum ProfileScreenState {
    case idle
    case loading
    case loaded
    case error(Error)
}
