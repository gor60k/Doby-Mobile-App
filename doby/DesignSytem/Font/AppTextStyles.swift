import SwiftUI

struct TextStyle {
    let font: Font
    let color: Color
}

struct AppTextStyles {
    static let largeTitleBlack = TextStyle(font: .AppFonts.largeTitleBlack, color: .primary)
    static let largeTitleHeavy = TextStyle(font: .AppFonts.largeTitleHeavy, color: .primary.opacity(0.9))
    static let largeTitleBold = TextStyle(font: .AppFonts.largeTitleBold, color: .primary.opacity(0.85))
    static let largeTitleSemibold = TextStyle(font: .AppFonts.largeTitleSemibold, color: .primary.opacity(0.8))
    static let largeTitleMedium = TextStyle(font: .AppFonts.largeTitleMedium, color: .secondary)
    static let largeTitleRegular = TextStyle(font: .AppFonts.largeTitleRegular, color: .secondary)
    static let largeTitleLight = TextStyle(font: .AppFonts.largeTitleLight, color: .secondary.opacity(0.8))
    static let largeTitleThin = TextStyle(font: .AppFonts.largeTitleThin, color: .secondary.opacity(0.6))
    static let largeTitleUltraLight = TextStyle(font: .AppFonts.largeTitleUltraLight, color: .secondary.opacity(0.4))
    
    static let titleBlack = TextStyle(font: .AppFonts.titleBlack, color: .primary)
    static let titleHeavy = TextStyle(font: .AppFonts.titleHeavy, color: .primary.opacity(0.9))
    static let titleBold = TextStyle(font: .AppFonts.titleBold, color: .primary.opacity(0.85))
    static let titleSemibold = TextStyle(font: .AppFonts.titleSemibold, color: .primary.opacity(0.8))
    static let titleMedium = TextStyle(font: .AppFonts.titleMedium, color: .secondary)
    static let titleRegular = TextStyle(font: .AppFonts.titleRegular, color: .secondary)
    static let titleLight = TextStyle(font: .AppFonts.titleLight, color: .secondary.opacity(0.8))
    static let titleThin = TextStyle(font: .AppFonts.titleThin, color: .secondary.opacity(0.6))
    static let titleUltraLight = TextStyle(font: .AppFonts.titleUltraLight, color: .secondary.opacity(0.4))
    
    static let headlineBlack = TextStyle(font: .AppFonts.headlineBlack, color: .primary)
    static let headlineHeavy = TextStyle(font: .AppFonts.headlineHeavy, color: .primary.opacity(0.9))
    static let headlineBold = TextStyle(font: .AppFonts.headlineBold, color: .primary.opacity(0.85))
    static let headlineSemibold = TextStyle(font: .AppFonts.headlineSemibold, color: .primary.opacity(0.8))
    static let headlineMedium = TextStyle(font: .AppFonts.headlineMedium, color: .secondary)
    static let headlineRegular = TextStyle(font: .AppFonts.headlineRegular, color: .secondary)
    static let headlineLight = TextStyle(font: .AppFonts.headlineLight, color: .secondary.opacity(0.8))
    static let headlineThin = TextStyle(font: .AppFonts.headlineThin, color: .secondary.opacity(0.6))
    static let headlineUltraLight = TextStyle(font: .AppFonts.headlineUltraLight, color: .secondary.opacity(0.4))
    
    static let bodyBlack = TextStyle(font: .AppFonts.bodyBlack, color: .primary)
    static let bodyHeavy = TextStyle(font: .AppFonts.bodyHeavy, color: .primary.opacity(0.9))
    static let bodyBold = TextStyle(font: .AppFonts.bodyBold, color: .primary.opacity(0.85))
    static let bodySemibold = TextStyle(font: .AppFonts.bodySemibold, color: .primary.opacity(0.8))
    static let bodyMedium = TextStyle(font: .AppFonts.bodyMedium, color: .secondary)
    static let bodyRegular = TextStyle(font: .AppFonts.bodyRegular, color: .secondary)
    static let bodyLight = TextStyle(font: .AppFonts.bodyLight, color: .secondary.opacity(0.8))
    static let bodyThin = TextStyle(font: .AppFonts.bodyThin, color: .secondary.opacity(0.6))
    static let bodyUltraLight = TextStyle(font: .AppFonts.bodyUltraLight, color: .secondary.opacity(0.4))
    
    static let subheadlineBlack = TextStyle(font: .AppFonts.subheadlineBlack, color: .primary)
    static let subheadlineHeavy = TextStyle(font: .AppFonts.subheadlineHeavy, color: .primary.opacity(0.9))
    static let subheadlineBold = TextStyle(font: .AppFonts.subheadlineBold, color: .primary.opacity(0.85))
    static let subheadlineSemibold = TextStyle(font: .AppFonts.subheadlineSemibold, color: .primary.opacity(0.8))
    static let subheadlineMedium = TextStyle(font: .AppFonts.subheadlineMedium, color: .secondary)
    static let subheadlineRegular = TextStyle(font: .AppFonts.subheadlineRegular, color: .secondary)
    static let subheadlineLight = TextStyle(font: .AppFonts.subheadlineLight, color: .secondary.opacity(0.8))
    static let subheadlineThin = TextStyle(font: .AppFonts.subheadlineThin, color: .secondary.opacity(0.6))
    static let subheadlineUltraLight = TextStyle(font: .AppFonts.subheadlineUltraLight, color: .secondary.opacity(0.4))
    
    static let footnoteBlack = TextStyle(font: .AppFonts.footnoteBlack, color: .primary)
    static let footnoteHeavy = TextStyle(font: .AppFonts.footnoteHeavy, color: .primary.opacity(0.9))
    static let footnoteBold = TextStyle(font: .AppFonts.footnoteBold, color: .primary.opacity(0.85))
    static let footnoteSemibold = TextStyle(font: .AppFonts.footnoteSemibold, color: .primary.opacity(0.8))
    static let footnoteMedium = TextStyle(font: .AppFonts.footnoteMedium, color: .secondary)
    static let footnoteRegular = TextStyle(font: .AppFonts.footnoteRegular, color: .secondary)
    static let footnoteLight = TextStyle(font: .AppFonts.footnoteLight, color: .secondary.opacity(0.8))
    static let footnoteThin = TextStyle(font: .AppFonts.footnoteThin, color: .secondary.opacity(0.6))
    static let footnoteUltraLight = TextStyle(font: .AppFonts.footnoteUltraLight, color: .secondary.opacity(0.4))
    
    static let captionBlack = TextStyle(font: .AppFonts.captionBlack, color: .primary)
    static let captionHeavy = TextStyle(font: .AppFonts.captionHeavy, color: .primary.opacity(0.9))
    static let captionBold = TextStyle(font: .AppFonts.captionBold, color: .primary.opacity(0.85))
    static let captionSemibold = TextStyle(font: .AppFonts.captionSemibold, color: .primary.opacity(0.8))
    static let captionMedium = TextStyle(font: .AppFonts.captionMedium, color: .secondary)
    static let captionRegular = TextStyle(font: .AppFonts.captionRegular, color: .secondary)
    static let captionLight = TextStyle(font: .AppFonts.captionLight, color: .secondary.opacity(0.8))
    static let captionThin = TextStyle(font: .AppFonts.captionThin, color: .secondary.opacity(0.6))
    static let captionUltraLight = TextStyle(font: .AppFonts.captionUltraLight, color: .secondary.opacity(0.4))
}
