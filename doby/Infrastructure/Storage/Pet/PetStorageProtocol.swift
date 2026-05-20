protocol PetStorageProtocol {
    var pets: [Pet] { get set }
    
    func load() async
    func set(_ pet: [Pet])
    func update(_ pet: Pet)
    func remove(id: Int)
    func clear()
}
