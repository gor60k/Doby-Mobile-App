import SwiftUI

struct ProfileDetailsView<Selection: Hashable>: View {
    @Binding var selection: Selection
    let aboutValue: Selection
    let feedbackValue: Selection
    let options: [Selection]
    let title: (Selection) -> String
    let bio: String
    
    var body: some View {
        VStack(alignment: .leading) {
            PrimaryPicker(
                selection: $selection,
                options: options,
                title: title
            )

            switch selection {
            case aboutValue: ProfileAboutView(bio: bio)
            case feedbackValue:
                VStack(spacing: 10) {
                    ForEach(0..<3, id: \.self) { _ in
                        PrimaryFeedback()
                    }
                }
            default: EmptyView()
            }
        }
    }
}
