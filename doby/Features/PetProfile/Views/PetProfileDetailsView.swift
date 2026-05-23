import SwiftUI

struct PetProfileDetailsView<Selection: Hashable>: View {
    @Binding var selection: Selection
    let aboutValue: Selection
    let feedbackValue: Selection
    let options: [Selection]
    let title: (Selection) -> String
    let description: String
    let buttonAction: () -> Void
    
    var body: some View {
        VStack {
            PrimaryPicker(
                selection: $selection,
                options: options,
                title: title
            )
            
            switch selection {
            case aboutValue:
                PetProfileAboutView(
                    description: description,
                    action: buttonAction
                )
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
