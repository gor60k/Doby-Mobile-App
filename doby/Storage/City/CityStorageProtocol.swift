protocol CityStorageProtocol {
    var cities: [City] { get set }
    
    func load() async
}
