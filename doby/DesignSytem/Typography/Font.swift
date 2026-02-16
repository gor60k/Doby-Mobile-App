import SwiftUI

extension Font {
    struct Custom {
        //MARK: - Large titles
        static let largeTitleBlack = Font.system(.largeTitle, design: .rounded, weight: .black)
        static let largeTitleHeavy = Font.system(.largeTitle, design: .rounded, weight: .heavy)
        static let largeTitleBold = Font.system(.largeTitle, design: .rounded, weight: .bold)
        static let largeTitleSemibold = Font.system(.largeTitle, design: .rounded, weight: .semibold)
        static let largeTitleMedium = Font.system(.largeTitle, design: .rounded, weight: .medium)
        static let largeTitleRegular = Font.system(.largeTitle, design: .rounded, weight: .regular)
        static let largeTitleLight = Font.system(.largeTitle, design: .rounded, weight: .light)
        static let largeTitleThin = Font.system(.largeTitle, design: .rounded, weight: .thin)
        static let largeTitleUltraLight = Font.system(.largeTitle, design: .rounded, weight: .ultraLight)
        
        //MARK: - Titles
        static let titleBlack = Font.system(.title, design: .rounded, weight: .black)
        static let titleHeavy = Font.system(.title, design: .rounded, weight: .heavy)
        static let titleBold = Font.system(.title, design: .rounded, weight: .bold)
        static let titleSemibold = Font.system(.title, design: .rounded, weight: .semibold)
        static let titleMedium = Font.system(.title, design: .rounded, weight: .medium)
        static let titleRegular = Font.system(.title, design: .rounded, weight: .regular)
        static let titleLight = Font.system(.title, design: .rounded, weight: .light)
        static let titleThin = Font.system(.title, design: .rounded, weight: .thin)
        static let titleUltraLight = Font.system(.title, design: .rounded, weight: .ultraLight)
        
        //MARK: - Headlines
        static let headlineBlack = Font.system(.headline, design: .rounded, weight: .black)
        static let headlineHeavy = Font.system(.headline, design: .rounded, weight: .heavy)
        static let headlineBold = Font.system(.headline, design: .rounded, weight: .bold)
        static let headlineSemibold = Font.system(.headline, design: .rounded, weight: .semibold)
        static let headlineMedium = Font.system(.headline, design: .rounded, weight: .medium)
        static let headlineRegular = Font.system(.headline, design: .rounded, weight: .regular)
        static let headlineLight = Font.system(.headline, design: .rounded, weight: .light)
        static let headlineThin = Font.system(.headline, design: .rounded, weight: .thin)
        static let headlineUltraLight = Font.system(.headline, design: .rounded, weight: .ultraLight)
        
        //MARK: - Body text
        static let bodyBlack = Font.system(.body, design: .rounded, weight: .black)
        static let bodyHeavy = Font.system(.body, design: .rounded, weight: .heavy)
        static let bodyBold = Font.system(.body, design: .rounded, weight: .bold)
        static let bodySemibold = Font.system(.body, design: .rounded, weight: .semibold)
        static let bodyMedium = Font.system(.body, design: .rounded, weight: .medium)
        static let bodyRegular = Font.system(.body, design: .rounded, weight: .regular)
        static let bodyLight = Font.system(.body, design: .rounded, weight: .light)
        static let bodyThin = Font.system(.body, design: .rounded, weight: .thin)
        static let bodyUltraLight = Font.system(.body, design: .rounded, weight: .ultraLight)
        
        //MARK: - Subheadlines
        static let subheadlineBlack = Font.system(.subheadline, design: .rounded, weight: .black)
        static let subheadlineHeavy = Font.system(.subheadline, design: .rounded, weight: .heavy)
        static let subheadlineBold = Font.system(.subheadline, design: .rounded, weight: .bold)
        static let subheadlineSemibold = Font.system(.subheadline, design: .rounded, weight: .semibold)
        static let subheadlineMedium = Font.system(.subheadline, design: .rounded, weight: .medium)
        static let subheadlineRegular = Font.system(.subheadline, design: .rounded, weight: .regular)
        static let subheadlineLight = Font.system(.subheadline, design: .rounded, weight: .light)
        static let subheadlineThin = Font.system(.subheadline, design: .rounded, weight: .thin)
        static let subheadlineUltraLight = Font.system(.subheadline, design: .rounded, weight: .ultraLight)
        
        //MARK: - Footnotes
        static let footnoteBlack = Font.system(.footnote, design: .rounded, weight: .black)
        static let footnoteHeavy = Font.system(.footnote, design: .rounded, weight: .heavy)
        static let footnoteBold = Font.system(.footnote, design: .rounded, weight: .bold)
        static let footnoteSemibold = Font.system(.footnote, design: .rounded, weight: .semibold)
        static let footnoteMedium = Font.system(.footnote, design: .rounded, weight: .medium)
        static let footnoteRegular = Font.system(.footnote, design: .rounded, weight: .regular)
        static let footnoteLight = Font.system(.footnote, design: .rounded, weight: .light)
        static let footnoteThin = Font.system(.footnote, design: .rounded, weight: .thin)
        static let footnoteUltraLight = Font.system(.footnote, design: .rounded, weight: .ultraLight)
        
        //MARK: - Caption
        static let captionBlack = Font.system(.caption, design: .rounded, weight: .black)
        static let captionHeavy = Font.system(.caption, design: .rounded, weight: .heavy)
        static let captionBold = Font.system(.caption, design: .rounded, weight: .bold)
        static let captionSemibold = Font.system(.caption, design: .rounded, weight: .semibold)
        static let captionMedium = Font.system(.caption, design: .rounded, weight: .medium)
        static let captionRegular = Font.system(.caption, design: .rounded, weight: .regular)
        static let captionLight = Font.system(.caption, design: .rounded, weight: .light)
        static let captionThin = Font.system(.caption, design: .rounded, weight: .thin)
        static let captionUltraLight = Font.system(.caption, design: .rounded, weight: .ultraLight)
    }
}

