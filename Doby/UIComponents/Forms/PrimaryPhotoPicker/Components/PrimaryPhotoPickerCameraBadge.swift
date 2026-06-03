import SwiftUI

struct PrimaryPhotoPickerCameraBadge: View {

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.accentColor)
                .frame(width: 28, height: 28)

            Image(systemName: "camera.fill")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white)
        }
    }
}
