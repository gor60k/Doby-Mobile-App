import SwiftUI

struct AppTextStyleViewModifier: ViewModifier {
    let style: AppTextStyle
    
    func body(content: Content) -> some View {
        content
            .font(style.font)
            .foregroundColor(style.color)
    }
}

extension AppTextStyle {
    
    static let title = AppTextStyle(
        font: Typography.title,
        color: TextColor.primary
    )
    
    static let subtitle = AppTextStyle(
        font: Typography.subtitle,
        color: TextColor.primary
    )

    static let primaryContent = AppTextStyle(
        font: Typography.primaryContent,
        color: TextColor.primary
    )
    
    static let secondaryContent = AppTextStyle(
        font: Typography.secondaryContent,
        color: TextColor.secondary
    )

    static let supportingContent = AppTextStyle(
        font: Typography.secondaryContent,
        color: TextColor.secondary
    )

    static let cardTitle = AppTextStyle(
        font: Typography.cardTitle,
        color: TextColor.primary
    )

    static let cardSubtitle = AppTextStyle(
        font: Typography.cardSubtitle,
        color: TextColor.secondary
    )

    static let metadata = AppTextStyle(
        font: Typography.metadata,
        color: TextColor.tertiary
    )

    static let destructiveAction = AppTextStyle(
        font: Typography.destructiveAction,
        color: TextColor.destructive
    )
}

extension View {
    func textStyle(
        _ style: AppTextStyle
    ) -> some View {
        modifier(AppTextStyleViewModifier(style: style))
    }
}
