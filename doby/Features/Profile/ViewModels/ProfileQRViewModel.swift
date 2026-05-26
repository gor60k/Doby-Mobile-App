import SwiftUI
import QRCode
import Observation

@MainActor
@Observable
final class ProfileQRViewModel {
    let userUUID: String
    let userImageURL: String?
    
    let profileURLString: String
    let primaryColor: Color
    
    var avatarURL: URL? {
        guard let userImageURL else { return nil }
        
        return APIConstants
            .getImageBaseURL()
            .appendingPathComponent(userImageURL)
    }
    
    var qrImage: UIImage? {
        generateQRImage()
    }
    
    private var logoUIImage: UIImage? {
        return UIImage(named: "MockLogo")
    }
    
    init(
        userUUID: String,
        userImageURL: String?,
        primaryColor: Color
    ) {
        self.userUUID = userUUID
        self.userImageURL = userImageURL
        self.profileURLString = "https://app.qutheory.com/profile/\(userUUID)"
        self.primaryColor = primaryColor
    }
    
    private func generateQRImage() -> UIImage? {
        guard let doc = try? QRCode.Document(utf8String: profileURLString) else {
            return nil
        }

        doc.design.backgroundColor(UIColor.white.cgColor)
        doc.design.foregroundColor(UIColor(primaryColor).cgColor)

        doc.design.shape.onPixels = QRCode.PixelShape.RoundedPath()

        doc.design.shape.eye = QRCode.EyeShape.RoundedRect()
        doc.design.shape.pupil = QRCode.PupilShape.RoundedRect()
        
        doc.errorCorrection = .high
        

        if let logo = logoUIImage,
           let cgLogo = logo.cgImage {

            doc.logoTemplate = QRCode.LogoTemplate(
                image: cgLogo,
                path: CGPath(
                    roundedRect: CGRect(
                        x: 0.37,
                        y: 0.37,
                        width: 0.26,
                        height: 0.26
                    ),
                    cornerWidth: 0.08,
                    cornerHeight: 0.08,
                    transform: nil
                ),
                inset: 0.08
            )
        }

        guard let cgImage = try? doc.cgImage(dimension: 800) else {
            return nil
        }

        return UIImage(cgImage: cgImage)
    }
}
