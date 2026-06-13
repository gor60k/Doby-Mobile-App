final class PrimaryFullScreenGallaryViewModel {
    var photos: [Photo] = []
    
    init(photos: [Photo]) {
        self.photos = photos
    }
    
}

extension PrimaryFullScreenGallaryViewModel {
    static var mock: PrimaryFullScreenGallaryViewModel {
        let photos: [Photo] = [
            Photo(
                id: 1,
                imageURL: "MockUserIcon",
                orderNumber: 1,
                isMain: true
            ),
            Photo(
                id: 2,
                imageURL: "MockUserIcon",
                orderNumber: 2,
                isMain: false
            ),
        ]
            
        return PrimaryFullScreenGallaryViewModel(photos: photos)
    }
}
