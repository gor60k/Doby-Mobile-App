import SwiftUI

struct PetProfileTagsView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService

    let tags: [String]

    var body: some View {
        FlowLayout(spacing: 10) {
            ForEach(tags, id: \.self) { tag in
                Text(tag)
                    .lineLimit(1)
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(primaryColorService.primaryColor.color, lineWidth: 1)
                    )
            }
        }
    }
}
