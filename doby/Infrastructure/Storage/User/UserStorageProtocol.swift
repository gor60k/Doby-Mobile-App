protocol UserStorageProtocol {
    var user: User? { get set }
    
    func load() async
    func set(_ user: User?)
    func update(_ block: (inout User) -> Void)
}

