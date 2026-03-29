import SwiftUI

struct AppTextStyle {
    let font: Font
    let color: Color
}

extension AppTextStyle {
    struct Presets {
        // MARK: - Large titles
        static let largeTitleBlack = AppTextStyle(font: .Custom.largeTitleBlack, color: .primary)
        static let largeTitleHeavy = AppTextStyle(font: .Custom.largeTitleHeavy, color: .primary.opacity(0.9))
        static let largeTitleBold = AppTextStyle(font: .Custom.largeTitleBold, color: .primary.opacity(0.85))
        static let largeTitleSemibold = AppTextStyle(font: .Custom.largeTitleSemibold, color: .primary.opacity(0.8))
        static let largeTitleMedium = AppTextStyle(font: .Custom.largeTitleMedium, color: .secondary)
        static let largeTitleRegular = AppTextStyle(font: .Custom.largeTitleRegular, color: .secondary)
        static let largeTitleLight = AppTextStyle(font: .Custom.largeTitleLight, color: .secondary.opacity(0.8))
        static let largeTitleThin = AppTextStyle(font: .Custom.largeTitleThin, color: .secondary.opacity(0.6))
        static let largeTitleUltraLight = AppTextStyle(font: .Custom.largeTitleUltraLight, color: .secondary.opacity(0.4))
        
        // MARK: - Titles
        static let titleBlack = AppTextStyle(font: .Custom.titleBlack, color: .primary)
        static let titleHeavy = AppTextStyle(font: .Custom.titleHeavy, color: .primary.opacity(0.9))
        static let titleBold = AppTextStyle(font: .Custom.titleBold, color: .primary.opacity(0.85))
        static let titleSemibold = AppTextStyle(font: .Custom.titleSemibold, color: .primary.opacity(0.8))
        static let titleMedium = AppTextStyle(font: .Custom.titleMedium, color: .secondary)
        static let titleRegular = AppTextStyle(font: .Custom.titleRegular, color: .secondary)
        static let titleLight = AppTextStyle(font: .Custom.titleLight, color: .secondary.opacity(0.8))
        static let titleThin = AppTextStyle(font: .Custom.titleThin, color: .secondary.opacity(0.6))
        static let titleUltraLight = AppTextStyle(font: .Custom.titleUltraLight, color: .secondary.opacity(0.4))
        
        // MARK: - Labels
        static let labelBlack = AppTextStyle(font: .Custom.labelBlack, color: .primary)
        static let labelHeavy = AppTextStyle(font: .Custom.labelHeavy, color: .primary.opacity(0.9))
        static let labelBold = AppTextStyle(font: .Custom.labelBold, color: .primary.opacity(0.85))
        static let labelSemibold = AppTextStyle(font: .Custom.labelSemibold, color: .primary.opacity(0.8))
        static let labelMedium = AppTextStyle(font: .Custom.labelMedium, color: .secondary)
        static let labelRegular = AppTextStyle(font: .Custom.labelRegular, color: .secondary)
        static let labelLight = AppTextStyle(font: .Custom.labelLight, color: .secondary.opacity(0.8))
        static let labelThin = AppTextStyle(font: .Custom.labelThin, color: .secondary.opacity(0.6))
        static let labelUltraLight = AppTextStyle(font: .Custom.labelUltraLight, color: .secondary.opacity(0.4))
        
        // MARK: - Headlines
        static let headlineBlack = AppTextStyle(font: .Custom.headlineBlack, color: .primary)
        static let headlineHeavy = AppTextStyle(font: .Custom.headlineHeavy, color: .primary.opacity(0.9))
        static let headlineBold = AppTextStyle(font: .Custom.headlineBold, color: .primary.opacity(0.85))
        static let headlineSemibold = AppTextStyle(font: .Custom.headlineSemibold, color: .primary.opacity(0.8))
        static let headlineMedium = AppTextStyle(font: .Custom.headlineMedium, color: .secondary)
        static let headlineRegular = AppTextStyle(font: .Custom.headlineRegular, color: .secondary)
        static let headlineLight = AppTextStyle(font: .Custom.headlineLight, color: .secondary.opacity(0.8))
        static let headlineThin = AppTextStyle(font: .Custom.headlineThin, color: .secondary.opacity(0.6))
        static let headlineUltraLight = AppTextStyle(font: .Custom.headlineUltraLight, color: .secondary.opacity(0.4))
        
        // MARK: - Body
        static let bodyBlack = AppTextStyle(font: .Custom.bodyBlack, color: .primary)
        static let bodyHeavy = AppTextStyle(font: .Custom.bodyHeavy, color: .primary.opacity(0.9))
        static let bodyBold = AppTextStyle(font: .Custom.bodyBold, color: .primary.opacity(0.85))
        static let bodySemibold = AppTextStyle(font: .Custom.bodySemibold, color: .primary.opacity(0.8))
        static let bodyMedium = AppTextStyle(font: .Custom.bodyMedium, color: .secondary)
        static let bodyRegular = AppTextStyle(font: .Custom.bodyRegular, color: .secondary)
        static let bodyLight = AppTextStyle(font: .Custom.bodyLight, color: .secondary.opacity(0.8))
        static let bodyThin = AppTextStyle(font: .Custom.bodyThin, color: .secondary.opacity(0.6))
        static let bodyUltraLight = AppTextStyle(font: .Custom.bodyUltraLight, color: .secondary.opacity(0.4))
        
        // MARK: - Subheadlines
        static let subheadlineBlack = AppTextStyle(font: .Custom.subheadlineBlack, color: .primary)
        static let subheadlineHeavy = AppTextStyle(font: .Custom.subheadlineHeavy, color: .primary.opacity(0.9))
        static let subheadlineBold = AppTextStyle(font: .Custom.subheadlineBold, color: .primary.opacity(0.85))
        static let subheadlineSemibold = AppTextStyle(font: .Custom.subheadlineSemibold, color: .primary.opacity(0.8))
        static let subheadlineMedium = AppTextStyle(font: .Custom.subheadlineMedium, color: .secondary)
        static let subheadlineRegular = AppTextStyle(font: .Custom.subheadlineRegular, color: .secondary)
        static let subheadlineLight = AppTextStyle(font: .Custom.subheadlineLight, color: .secondary.opacity(0.8))
        static let subheadlineThin = AppTextStyle(font: .Custom.subheadlineThin, color: .secondary.opacity(0.6))
        static let subheadlineUltraLight = AppTextStyle(font: .Custom.subheadlineUltraLight, color: .secondary.opacity(0.4))
        
        // MARK: - Footnotes
        static let footnoteBlack = AppTextStyle(font: .Custom.footnoteBlack, color: .primary)
        static let footnoteHeavy = AppTextStyle(font: .Custom.footnoteHeavy, color: .primary.opacity(0.9))
        static let footnoteBold = AppTextStyle(font: .Custom.footnoteBold, color: .primary.opacity(0.85))
        static let footnoteSemibold = AppTextStyle(font: .Custom.footnoteSemibold, color: .primary.opacity(0.8))
        static let footnoteMedium = AppTextStyle(font: .Custom.footnoteMedium, color: .secondary)
        static let footnoteRegular = AppTextStyle(font: .Custom.footnoteRegular, color: .secondary)
        static let footnoteLight = AppTextStyle(font: .Custom.footnoteLight, color: .secondary.opacity(0.8))
        static let footnoteThin = AppTextStyle(font: .Custom.footnoteThin, color: .secondary.opacity(0.6))
        static let footnoteUltraLight = AppTextStyle(font: .Custom.footnoteUltraLight, color: .secondary.opacity(0.4))
        
        // MARK: - Captions
        static let captionBlack = AppTextStyle(font: .Custom.captionBlack, color: .primary)
        static let captionHeavy = AppTextStyle(font: .Custom.captionHeavy, color: .primary.opacity(0.9))
        static let captionBold = AppTextStyle(font: .Custom.captionBold, color: .primary.opacity(0.85))
        static let captionSemibold = AppTextStyle(font: .Custom.captionSemibold, color: .primary.opacity(0.8))
        static let captionMedium = AppTextStyle(font: .Custom.captionMedium, color: .secondary)
        static let captionRegular = AppTextStyle(font: .Custom.captionRegular, color: .secondary)
        static let captionLight = AppTextStyle(font: .Custom.captionLight, color: .secondary.opacity(0.8))
        static let captionThin = AppTextStyle(font: .Custom.captionThin, color: .secondary.opacity(0.6))
        static let captionUltraLight = AppTextStyle(font: .Custom.captionUltraLight, color: .secondary.opacity(0.4))
    }

}
