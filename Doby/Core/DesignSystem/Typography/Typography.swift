import SwiftUI

enum Typography {
    
    /// Main title
    static let title = Font.system(
        .largeTitle,
        design: .rounded,
        weight: .bold
    )
    
    /// Subtitle
    static let subtitle = Font.system(
        .title,
        design: .rounded,
        weight: .semibold
    )

    /// Main content text
    static let primaryContent = Font.system(
        .body,
        design: .rounded
    )

    /// Supporting content text
    static let secondaryContent = Font.system(
        .subheadline,
        design: .rounded
    )

    /// Card title
    static let cardTitle = Font.system(
        .headline,
        design: .rounded,
        weight: .semibold
    )

    /// Card subtitle
    static let cardSubtitle = Font.system(
        .subheadline,
        design: .rounded,
        weight: .regular
    )

    /// Metadata, timestamps, badges, helper text
    static let metadata = Font.system(
        .caption,
        design: .rounded
    )

    /// Destructive actions
    static let destructiveAction = Font.system(
        .body,
        design: .rounded,
        weight: .semibold
    )
}
