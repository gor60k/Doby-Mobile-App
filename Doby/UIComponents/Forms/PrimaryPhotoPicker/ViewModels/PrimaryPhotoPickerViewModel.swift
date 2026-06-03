import SwiftUI
import Observation
import PhotosUI

@Observable
final class PrimaryPhotoPickerViewModel {
    var selectedPhotoImage: UIImage?
    var isProcessing = false
    
    func processPhoto(_ item: PhotosPickerItem) async -> Data? {
        await MainActor.run {
            isProcessing = true
        }

        defer {
            Task { @MainActor in
                self.isProcessing = false
            }
        }
        
        guard let data = try? await item.loadTransferable(type: Data.self),
              let image = UIImage(data: data) else { return nil }
        
        let maxDimension: CGFloat = 1200
        let originalSize = image.size
        
        let scale = min(
            maxDimension / originalSize.width,
            maxDimension / originalSize.height,
            1
        )

        let resizedSize = CGSize(
            width: originalSize.width * scale,
            height: originalSize.height * scale
        )

        let rendererFormat = UIGraphicsImageRendererFormat.default()
        rendererFormat.scale = 1

        let renderer = UIGraphicsImageRenderer(
            size: resizedSize,
            format: rendererFormat
        )

        let resizedImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: resizedSize))
        }

        guard let compressedData = resizedImage.jpegData(compressionQuality: 0.35) else {
            return nil
        }
        
        await MainActor.run {
            selectedPhotoImage = resizedImage
        }
        
        return compressedData
    }
}
